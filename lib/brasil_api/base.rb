# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Cliente HTTP compartilhado pelas famílias de endpoint.
  #
  # @see https://brasilapi.com.br/docs
  class Base
    # Origem das requisições, sem barra no final.
    BASE_URL = "https://brasilapi.com.br/api"

    class << self
      # Executa um GET e devolve o JSON interpretado.
      #
      # Chaves +nil+ em +params+ não entram na query.
      #
      # @param path [String] caminho a partir de +/api+, começando com +/+
      # @param params [Hash{Symbol,String=>Object}] query string
      # @return [Hash, Array, nil] corpo JSON, ou +nil+ quando o corpo vem vazio
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Base.get("/banks/v1")
      def get(path, params = {})
        request_data(build_uri(path, params))
      end

      protected

      # Formata uma data para +YYYY-MM-DD+.
      #
      # @api private
      # @param value [Date, Time, DateTime, String] data ou texto já formatado
      # @return [String]
      def format_date(value)
        return value.strftime("%Y-%m-%d") if value.respond_to?(:strftime)

        value
      end

      # Traduz chaves da gem para os nomes de query da BrasilAPI.
      #
      # @api private
      # @param filters [Hash{Symbol=>Object}] filtros recebidos pelo método público
      # @param mapping [Hash{Symbol=>Symbol}] chave da gem para chave da API
      # @return [Hash{Symbol=>Object}]
      def translate(filters, mapping)
        filters.to_h { |key, value| [mapping.fetch(key), value] }
      end

      # Interpreta a resposta ou converte a falha em erro da gem.
      #
      # @api private
      # @param uri [URI] URL completa
      # @return [Hash, Array, nil]
      # @raise [BrasilAPI::Error]
      # @raise [BrasilAPI::Timeout]
      def request_data(uri)
        response = perform_request(uri)
        return parsed_body(response) if response.is_a?(Net::HTTPSuccess)

        raise_api_error(response)
      rescue Net::OpenTimeout, Net::ReadTimeout => e
        raise BrasilAPI::Timeout, e.message
      end

      private

      # Monta a URL, omitindo parâmetros +nil+.
      #
      # @api private
      # @param path [String]
      # @param params [Hash]
      # @return [URI]
      def build_uri(path, params)
        uri = URI.parse("#{BASE_URL}#{encode_path(path)}")
        query = params.compact
        uri.query = URI.encode_www_form(query) unless query.empty?
        uri
      end

      # Escapa cada segmento do caminho.
      #
      # @api private
      # @param path [String]
      # @return [String]
      def encode_path(path)
        path.split("/", -1).map { |segment| encode_segment(segment) }.join("/")
      end

      # Codifica um segmento do caminho.
      #
      # Cada segmento é escapado sozinho para que "?", "#" e espaços permaneçam no path.
      # +URI.encode_uri_component+ mantém espaços como +%20+, igual aos cassettes gravados.
      #
      # @api private
      # @param segment [String]
      # @return [String]
      def encode_segment(segment)
        URI.encode_uri_component(segment)
      end

      # Abre a conexão e envia o GET.
      #
      # @api private
      # @param uri [URI]
      # @return [Net::HTTPResponse]
      def perform_request(uri)
        Net::HTTP.start(
          uri.hostname,
          uri.port,
          use_ssl: uri.scheme == "https",
          open_timeout: BrasilAPI.config.timeout,
          read_timeout: BrasilAPI.config.timeout
        ) do |http|
          http.request(Net::HTTP::Get.new(uri))
        end
      end

      # Interpreta o corpo de uma resposta de sucesso.
      #
      # @api private
      # @param response [Net::HTTPResponse]
      # @return [Hash, Array, nil]
      def parsed_body(response)
        body = utf8_body(response)
        return if body.nil? || body.empty?

        JSON.parse(body)
      end

      # Converte uma resposta de erro na exceção correspondente.
      #
      # @api private
      # @param response [Net::HTTPResponse]
      # @return [void]
      # @raise [BrasilAPI::Error]
      def raise_api_error(response)
        parsed = parse_error_body(response)
        raise error_class_for(response).new(
          error_message(parsed, response),
          status: response.code.to_i,
          body: error_body(parsed, response),
          type: error_type(parsed)
        )
      end

      # Interpreta o corpo de erro, ou +nil+ quando não é JSON.
      #
      # @api private
      # @param response [Net::HTTPResponse]
      # @return [Hash, Array, nil]
      def parse_error_body(response)
        body = utf8_body(response)
        return if body.nil? || body.empty?

        JSON.parse(body)
      rescue JSON::ParserError
        nil
      end

      # Lê o corpo forçando UTF-8.
      #
      # @api private
      # @param response [Net::HTTPResponse]
      # @return [String, nil]
      def utf8_body(response)
        body = response.body
        return if body.nil?

        body.dup.force_encoding(Encoding::UTF_8)
      end

      # Escolhe a mensagem exposta pela exceção.
      #
      # @api private
      # @param parsed [Hash, Array, nil]
      # @param response [Net::HTTPResponse]
      # @return [String]
      def error_message(parsed, response)
        return parsed["message"] if parsed.is_a?(Hash) && parsed["message"]

        body = utf8_body(response)
        return body if body && !body.empty?

        "HTTP #{response.code}"
      end

      # Escolhe o corpo exposto pela exceção.
      #
      # @api private
      # @param parsed [Hash, Array, nil]
      # @param response [Net::HTTPResponse]
      # @return [Hash, Array, String, nil]
      def error_body(parsed, response)
        return parsed unless parsed.nil?

        utf8_body(response)
      end

      # Lê o campo +type+ quando o corpo é um objeto.
      #
      # @api private
      # @param parsed [Hash, Array, nil]
      # @return [String, nil]
      def error_type(parsed)
        parsed["type"] if parsed.is_a?(Hash)
      end

      # Associa o código HTTP à classe de erro.
      #
      # @api private
      # @param response [Net::HTTPResponse]
      # @return [Class]
      def error_class_for(response)
        case response.code.to_i
        when 400
          BrasilAPI::BadRequest
        when 404
          BrasilAPI::NotFound
        when 500..599
          BrasilAPI::ServerError
        else
          BrasilAPI::Error
        end
      end
    end
  end
end
