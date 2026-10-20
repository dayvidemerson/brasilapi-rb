# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Feriados nacionais e, quando a UF é informada, feriados estaduais.
  #
  # @see https://brasilapi.com.br/docs#tag/FERIADOS
  class Holiday < Base
    class << self
      # Lista os feriados de um ano.
      #
      # +state+ vira o parâmetro +uf+ e só é enviado quando presente.
      #
      # @param year [String, Integer] ano com quatro dígitos
      # @param state [String, nil] sigla da UF dos feriados estaduais
      # @return [Array<Hash>] data, nome e tipo de cada feriado
      # @raise [BrasilAPI::BadRequest] quando o ano é inválido
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Feriados de São Paulo em 2024
      #   BrasilAPI::Holiday.by_year(2024, state: "SP")
      # @see https://brasilapi.com.br/docs#tag/FERIADOS
      def by_year(year, state: nil)
        get("/feriados/v1/#{year}", { uf: state })
      end
    end
  end
end
