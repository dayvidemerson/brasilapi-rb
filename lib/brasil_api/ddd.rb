# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Códigos DDD e as localidades que eles atendem.
  #
  # @see https://brasilapi.com.br/docs#tag/DDD
  class DDD < Base
    class << self
      # Lista todos os DDDs.
      #
      # @return [Array<Hash>] estado e cidades de cada DDD
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::DDD.all
      # @see https://brasilapi.com.br/docs#tag/DDD
      def all
        get("/ddd/v1")
      end

      # Busca as cidades de um DDD.
      #
      # A v2 é o padrão. +version: 1+ consulta a rota antiga.
      #
      # @param ddd [String, Integer] código DDD
      # @param version [Integer] versão da rota, +1+ ou +2+
      # @return [Hash] estado e cidades atendidas
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o DDD não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example DDD 11 na v2
      #   BrasilAPI::DDD.find(11)
      # @example DDD 86 na v1
      #   BrasilAPI::DDD.find(86, version: 1)
      # @see https://brasilapi.com.br/docs#tag/DDD
      def find(ddd, version: 2)
        get("/ddd/v#{version}/#{ddd}")
      end

      # Lista os DDDs de uma unidade federativa.
      #
      # @param state [String] sigla da UF
      # @return [Array<Hash>] DDDs da UF
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a UF não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example DDDs de São Paulo
      #   BrasilAPI::DDD.by_state("SP")
      # @see https://brasilapi.com.br/docs#tag/DDD
      def by_state(state)
        get("/ddd/uf/v1/#{state}")
      end
    end
  end
end
