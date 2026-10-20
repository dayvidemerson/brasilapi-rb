# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Irradiação solar média por localidade.
  #
  # @see https://brasilapi.com.br/docs#tag/SOLAR
  class Solar < Base
    class << self
      # Consulta a incidência solar de uma localidade.
      #
      # A rota é +/solar/v1+ e +location+ pode ser uma cidade ou um par latitude,longitude.
      #
      # @param location [String] localidade, por exemplo +"Teresina"+
      # @return [Hash] irradiação média da localidade
      # @raise [BrasilAPI::BadRequest] quando a localidade é inválida
      # @raise [BrasilAPI::NotFound] quando a localidade não é encontrada
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Solar.incidence("Teresina")
      # @see https://brasilapi.com.br/docs#tag/SOLAR
      def incidence(location)
        get("/solar/v1", { location: location })
      end
    end
  end
end
