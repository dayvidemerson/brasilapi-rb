# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Consulta CEP e o DDD de um código de área.
  #
  # @see https://brasilapi.com.br/docs#tag/CEP
  # @see https://brasilapi.com.br/docs#tag/DDD
  class Address < Base
    class << self
      # Busca o endereço de um CEP.
      #
      # Com +location: true+ a rota é a v2 e a resposta inclui coordenadas.
      #
      # @param zip_code [String] CEP, com ou sem hífen
      # @param location [Boolean] usa +/cep/v2+ quando +true+
      # @return [Hash] logradouro, bairro, cidade e UF
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o CEP não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Avenida Frei Serafim, em Teresina
      #   BrasilAPI::Address.find_by_zip_code("64001100")
      # @example CEP com latitude e longitude
      #   BrasilAPI::Address.find_by_zip_code("80060000", location: true)
      # @see https://brasilapi.com.br/docs#tag/CEP
      def find_by_zip_code(zip_code, location: false)
        return get("/cep/v2/#{zip_code}") if location

        get("/cep/v1/#{zip_code}")
      end

      # Lista o estado e as cidades de um DDD.
      #
      # @param area_code [String, Integer] código DDD, por exemplo +"11"+
      # @return [Hash] estado e cidades atendidas
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o DDD não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example DDD de São Paulo
      #   BrasilAPI::Address.state_and_cities_by_area_code(11)
      # @see https://brasilapi.com.br/docs#tag/DDD
      def state_and_cities_by_area_code(area_code)
        get("/ddd/v1/#{area_code}")
      end
    end
  end
end
