# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Terminologia Unificada da Saúde Suplementar.
  #
  # @see https://brasilapi.com.br/docs#tag/TUSS
  class TUSS < Base
    # Filtros de listagem, busca e autocompletar, e o nome enviado na query.
    #
    # @return [Hash{Symbol=>Symbol}]
    PARAMS = {
      query: :q,
      name: :name,
      code: :tuss,
      match: :match,
      sort: :sort,
      order: :order,
      fields: :fields,
      limit: :limit,
      offset: :offset
    }.freeze

    class << self
      # Lista procedimentos da TUSS.
      #
      # @param filters [Hash] filtros opcionais
      # @option filters [String] :query texto livre (+q+)
      # @option filters [String] :name nome do procedimento
      # @option filters [String] :code código TUSS (+tuss+)
      # @option filters [String] :match modo de correspondência
      # @option filters [String] :sort campo de ordenação
      # @option filters [String] :order direção da ordenação
      # @option filters [String] :fields campos devolvidos
      # @option filters [Integer] :limit quantidade máxima de itens
      # @option filters [Integer] :offset deslocamento da página
      # @return [Hash] total e lista de procedimentos
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Primeiro procedimento
      #   BrasilAPI::TUSS.all(limit: 1)
      # @see https://brasilapi.com.br/docs#tag/TUSS
      def all(**filters)
        get("/tuss/v1", translate(filters, PARAMS))
      end

      # Busca um procedimento pelo código TUSS.
      #
      # @param code [String, Integer] código do procedimento
      # @return [Hash] descrição do procedimento
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o código não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Consulta em consultório
      #   BrasilAPI::TUSS.find_by_code("10101012")
      # @see https://brasilapi.com.br/docs#tag/TUSS
      def find_by_code(code)
        get("/tuss/v1/#{code}")
      end

      # Procura procedimentos por texto e filtros.
      #
      # @param filters [Hash] filtros opcionais; as chaves são as de {PARAMS}
      # @option filters [String] :query texto livre (+q+)
      # @option filters [String] :name nome do procedimento
      # @option filters [String] :code código TUSS (+tuss+)
      # @option filters [String] :match modo de correspondência
      # @option filters [String] :sort campo de ordenação
      # @option filters [String] :order direção da ordenação
      # @option filters [String] :fields campos devolvidos
      # @option filters [Integer] :limit quantidade máxima de itens
      # @option filters [Integer] :offset deslocamento da página
      # @return [Hash] total e procedimentos encontrados
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::TUSS.search(query: "consulta", limit: 1)
      # @see https://brasilapi.com.br/docs#tag/TUSS
      def search(**filters)
        get("/tuss/v1/search", translate(filters, PARAMS))
      end

      # Sugere procedimentos a partir de um prefixo.
      #
      # @param filters [Hash] filtros opcionais; as chaves são as de {PARAMS}
      # @option filters [String] :query texto livre (+q+)
      # @option filters [String] :name nome do procedimento
      # @option filters [String] :code código TUSS (+tuss+)
      # @option filters [String] :match modo de correspondência
      # @option filters [String] :sort campo de ordenação
      # @option filters [String] :order direção da ordenação
      # @option filters [String] :fields campos devolvidos
      # @option filters [Integer] :limit quantidade máxima de itens
      # @option filters [Integer] :offset deslocamento da página
      # @return [Hash] sugestões de procedimentos
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::TUSS.autocomplete(query: "cons", limit: 5)
      # @see https://brasilapi.com.br/docs#tag/TUSS
      def autocomplete(**filters)
        get("/tuss/v1/autocomplete", translate(filters, PARAMS))
      end
    end
  end
end
