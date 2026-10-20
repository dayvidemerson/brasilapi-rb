# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Cotações de moedas em relação ao real.
  #
  # @see https://brasilapi.com.br/docs#tag/CAMBIO
  class Cambio < Base
    class << self
      # Lista as moedas com cotação disponível.
      #
      # @return [Array<Hash>] símbolo e nome de cada moeda
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Cambio.currencies
      # @see https://brasilapi.com.br/docs#tag/CAMBIO
      def currencies
        get("/cambio/v1/moedas")
      end

      # Consulta a cotação PTAX de uma moeda em uma data.
      #
      # @param currency [String] código ISO, por exemplo +"USD"+
      # @param date [Date, Time, DateTime, String] data da cotação
      # @return [Hash] compra, venda e data da cotação
      # @raise [BrasilAPI::BadRequest] quando a moeda ou a data é inválida
      # @raise [BrasilAPI::NotFound] quando não há cotação na data
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Dólar em 15 de janeiro de 2024
      #   BrasilAPI::Cambio.quote("USD", "2024-01-15")
      # @see https://brasilapi.com.br/docs#tag/CAMBIO
      def quote(currency, date)
        get("/cambio/v1/cotacao/#{currency}/#{format_date(date)}")
      end
    end
  end
end
