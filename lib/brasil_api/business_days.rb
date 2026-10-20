# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Dias úteis entre duas datas.
  #
  # @see https://brasilapi.com.br/docs#tag/DIAS-UTEIS
  class BusinessDays < Base
    class << self
      # Conta os dias úteis de um intervalo, inclusive as extremidades.
      #
      # +include_national_holidays+ vira +incluirFeriadosNacionais+.
      # +nil+ omite o parâmetro (a API exclui feriados nacionais).
      # +false+ é enviado e faz o intervalo tratar feriados como dias úteis.
      #
      # @param start_date [Date, Time, DateTime, String] data inicial
      # @param end_date [Date, Time, DateTime, String] data final
      # @param include_national_holidays [Boolean, nil] trata feriados como dias úteis quando +false+
      # @return [Hash] quantidade de dias úteis e a lista de datas
      # @raise [BrasilAPI::BadRequest] quando o intervalo é inválido
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Primeira quinzena de janeiro de 2024, sem o feriado do dia 1º
      #   BrasilAPI::BusinessDays.between("2024-01-01", "2024-01-10")
      # @see https://brasilapi.com.br/docs#tag/DIAS-UTEIS
      def between(start_date, end_date, include_national_holidays: nil)
        get(
          "/diasuteis/v1",
          {
            dataInicial: format_date(start_date),
            dataFinal: format_date(end_date),
            incluirFeriadosNacionais: include_national_holidays
          }
        )
      end
    end
  end
end
