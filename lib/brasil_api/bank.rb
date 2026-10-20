# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Bancos participantes do Sistema de Transferência de Reservas.
  #
  # @see https://brasilapi.com.br/docs#tag/BANKS
  class Bank < Base
    class << self
      # Lista os bancos participantes do STR.
      #
      # @return [Array<Hash>] código, nome e ISPB de cada banco
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Bank.all
      # @see https://brasilapi.com.br/docs#tag/BANKS
      def all
        get("/banks/v1")
      end

      # Busca um banco pelo código de compensação.
      #
      # @param code [String, Integer] código COMPE, por exemplo +77+
      # @return [Hash] dados do banco
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o código não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Banco Inter
      #   BrasilAPI::Bank.find_by_code(77)
      # @see https://brasilapi.com.br/docs#tag/BANKS
      def find_by_code(code)
        get("/banks/v1/#{code}")
      end
    end
  end
end
