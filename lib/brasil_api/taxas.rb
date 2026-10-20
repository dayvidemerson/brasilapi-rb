# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Taxas de juros e índices oficiais.
  #
  # @see https://brasilapi.com.br/docs#tag/TAXAS
  class Taxas < Base
    class << self
      # Lista as taxas e os índices acompanhados pela BrasilAPI.
      #
      # @return [Array<Hash>] nome e valor de cada taxa
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Taxas.all
      # @see https://brasilapi.com.br/docs#tag/TAXAS
      def all
        get("/taxas/v1")
      end

      # Busca uma taxa pelo nome.
      #
      # @param name [String] nome da taxa, por exemplo +"selic"+ ou +"ipca"+
      # @return [Hash] nome e valor da taxa
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o nome não existe
      # @raise [BrasilAPI::ServerError] quando a fonte da taxa está indisponível
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Taxa Selic
      #   BrasilAPI::Taxas.find_by_name("selic")
      # @see https://brasilapi.com.br/docs#tag/TAXAS
      def find_by_name(name)
        get("/taxas/v1/#{name}")
      end
    end
  end
end
