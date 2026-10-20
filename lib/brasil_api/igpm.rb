# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Índice Geral de Preços do Mercado.
  #
  # @see https://brasilapi.com.br/docs#tag/IGPM
  class IGPM < Base
    class << self
      # Lista a série histórica do IGP-M.
      #
      # @return [Array<Hash>] mês e valor de cada apuração
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::IGPM.all
      # @see https://brasilapi.com.br/docs#tag/IGPM
      def all
        get("/indices/igpm/v1")
      end

      # Devolve as apurações mais recentes.
      #
      # @param limit [Integer] quantidade de meses
      # @return [Array<Hash>] últimas apurações, da mais nova para a mais antiga
      # @raise [BrasilAPI::BadRequest] quando o limite é inválido
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Dois últimos meses
      #   BrasilAPI::IGPM.last(2)
      # @see https://brasilapi.com.br/docs#tag/IGPM
      def last(limit)
        get("/indices/igpm/v1/ultimos", { limit: limit })
      end

      # Lista as apurações entre duas datas.
      #
      # @param initial_date [Date, Time, DateTime, String] início do intervalo
      # @param final_date [Date, Time, DateTime, String] fim do intervalo
      # @return [Array<Hash>] apurações do período
      # @raise [BrasilAPI::BadRequest] quando o intervalo é inválido
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Janeiro de 2024
      #   BrasilAPI::IGPM.between("2024-01-01", "2024-02-01")
      # @see https://brasilapi.com.br/docs#tag/IGPM
      def between(initial_date, final_date)
        get(
          "/indices/igpm/v1/intervalo",
          { initial_date: format_date(initial_date), final_date: format_date(final_date) }
        )
      end
    end
  end
end
