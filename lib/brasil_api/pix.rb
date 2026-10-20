# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Participantes do arranjo de pagamentos PIX.
  #
  # @see https://brasilapi.com.br/docs#tag/PIX
  class PIX < Base
    class << self
      # Lista as instituições participantes do PIX.
      #
      # @return [Array<Hash>] ISPB, nome e modalidade de cada participante
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::PIX.all
      # @see https://brasilapi.com.br/docs#tag/PIX
      def all
        get("/pix/v1/participants")
      end
    end
  end
end
