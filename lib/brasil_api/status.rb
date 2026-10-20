# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Saúde dos serviços da BrasilAPI.
  #
  # @see https://brasilapi.com.br/docs#tag/STATUS
  class Status < Base
    class << self
      # Consulta o status atual da BrasilAPI.
      #
      # @return [Hash] status geral e a situação de cada serviço
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Status.check
      # @see https://brasilapi.com.br/docs#tag/STATUS
      def check
        get("/status/v1")
      end
    end
  end
end
