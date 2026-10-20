# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Geocodificação reversa a partir de latitude e longitude.
  #
  # @see https://brasilapi.com.br/docs#tag/GEOLOCATION
  class Geolocation < Base
    class << self
      # Descobre o endereço de um ponto.
      #
      # +language+ vira o parâmetro homônimo e some da query quando +nil+.
      #
      # @param latitude [Float, String] latitude em graus decimais
      # @param longitude [Float, String] longitude em graus decimais
      # @param language [String, nil] idioma da resposta, por exemplo +"pt"+ ou +"en"+
      # @return [Hash] país, estado, cidade e endereço aproximado
      # @raise [BrasilAPI::BadRequest] quando as coordenadas são inválidas
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Centro de São Paulo, em português
      #   BrasilAPI::Geolocation.reverse(-23.55, -46.63, language: "pt")
      # @see https://brasilapi.com.br/docs#tag/GEOLOCATION
      def reverse(latitude, longitude, language: nil)
        get("/geolocation/v1", { latitude: latitude, longitude: longitude, language: language })
      end
    end
  end
end
