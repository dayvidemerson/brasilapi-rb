# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

module BrasilAPI
  class Base
    BASE_URL = "https://brasilapi.com.br/api"

    class << self
      def get(path, params = {})
        request_data(build_uri(path, params))
      end

      protected

      def format_date(value)
        return value.strftime("%Y-%m-%d") if value.respond_to?(:strftime)

        value
      end

      def translate(filters, mapping)
        filters.to_h { |key, value| [mapping.fetch(key), value] }
      end

      def request_data(uri)
        response = perform_request(uri)
        return parsed_body(response) if response.is_a?(Net::HTTPSuccess)

        raise_api_error(response)
      rescue Net::OpenTimeout, Net::ReadTimeout => e
        raise BrasilAPI::Timeout, e.message
      end

      private

      def build_uri(path, params)
        uri = URI.parse("#{BASE_URL}#{encode_path(path)}")
        query = params.compact
        uri.query = URI.encode_www_form(query) unless query.empty?
        uri
      end

      def encode_path(path)
        path.split("/", -1).map { |segment| encode_segment(segment) }.join("/")
      end

      # Encode each segment on its own so "?", "#" and spaces stay inside the path.
      # encode_uri_component keeps spaces as %20, matching the recorded cassettes.
      def encode_segment(segment)
        URI.encode_uri_component(segment)
      end

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

      def parsed_body(response)
        body = utf8_body(response)
        return if body.nil? || body.empty?

        JSON.parse(body)
      end

      def raise_api_error(response)
        parsed = parse_error_body(response)
        raise error_class_for(response).new(
          error_message(parsed, response),
          status: response.code.to_i,
          body: error_body(parsed, response),
          type: error_type(parsed)
        )
      end

      def parse_error_body(response)
        body = utf8_body(response)
        return if body.nil? || body.empty?

        JSON.parse(body)
      rescue JSON::ParserError
        nil
      end

      def utf8_body(response)
        body = response.body
        return if body.nil?

        body.dup.force_encoding(Encoding::UTF_8)
      end

      def error_message(parsed, response)
        return parsed["message"] if parsed.is_a?(Hash) && parsed["message"]

        body = utf8_body(response)
        return body if body && !body.empty?

        "HTTP #{response.code}"
      end

      def error_body(parsed, response)
        return parsed unless parsed.nil?

        utf8_body(response)
      end

      def error_type(parsed)
        parsed["type"] if parsed.is_a?(Hash)
      end

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
