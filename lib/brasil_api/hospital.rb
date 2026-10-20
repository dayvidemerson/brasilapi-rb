# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Estabelecimentos de saúde do CNES.
  #
  # @see https://brasilapi.com.br/docs#tag/HOSPITAIS
  class Hospital < Base
    # Filtros de {Hospital.all} e o nome enviado na query.
    #
    # @return [Hash{Symbol=>Symbol}]
    LIST_PARAMS = {
      vertical: :vertical,
      state: :uf,
      city: :municipio,
      service: :atendimento,
      query: :q,
      limit: :limit,
      offset: :offset
    }.freeze

    # Filtros de {Hospital.nearby} e o nome enviado na query.
    #
    # @return [Hash{Symbol=>Symbol}]
    NEARBY_PARAMS = {
      zip_code: :cep,
      latitude: :latitude,
      longitude: :longitude,
      city: :municipio,
      state: :uf,
      radius: :raio_km,
      vertical: :vertical,
      service: :atendimento,
      limit: :limit,
      offset: :offset
    }.freeze

    class << self
      # Lista estabelecimentos de saúde.
      #
      # @param filters [Hash] filtros opcionais
      # @option filters [String] :vertical vertical do estabelecimento
      # @option filters [String] :state sigla da UF (+uf+)
      # @option filters [String] :city município (+municipio+)
      # @option filters [String] :service tipo de atendimento (+atendimento+)
      # @option filters [String] :query texto livre (+q+)
      # @option filters [Integer] :limit quantidade máxima de itens
      # @option filters [Integer] :offset deslocamento da página
      # @return [Hash] total e lista de estabelecimentos
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Hospitais de Teresina
      #   BrasilAPI::Hospital.all(state: "PI", city: "TERESINA", limit: 1)
      # @see https://brasilapi.com.br/docs#tag/HOSPITAIS
      def all(**filters)
        get("/hospitais/v1", translate(filters, LIST_PARAMS))
      end

      # Lista estabelecimentos próximos de um CEP ou de um ponto.
      #
      # @param filters [Hash] filtros opcionais
      # @option filters [String] :zip_code CEP de referência (+cep+)
      # @option filters [Float] :latitude latitude de referência
      # @option filters [Float] :longitude longitude de referência
      # @option filters [String] :city município (+municipio+)
      # @option filters [String] :state sigla da UF (+uf+)
      # @option filters [Numeric] :radius raio em quilômetros (+raio_km+)
      # @option filters [String] :vertical vertical do estabelecimento
      # @option filters [String] :service tipo de atendimento (+atendimento+)
      # @option filters [Integer] :limit quantidade máxima de itens
      # @option filters [Integer] :offset deslocamento da página
      # @return [Hash] estabelecimentos ordenados por distância
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Vizinhos do CEP 64001-100
      #   BrasilAPI::Hospital.nearby(zip_code: "64001100", limit: 1)
      # @see https://brasilapi.com.br/docs#tag/HOSPITAIS
      def nearby(**filters)
        get("/hospitais/v1/proximos", translate(filters, NEARBY_PARAMS))
      end

      # Lista os valores aceitos nos filtros de hospitais.
      #
      # @return [Hash] verticais, atendimentos e demais opções
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Hospital.options
      # @see https://brasilapi.com.br/docs#tag/HOSPITAIS
      def options
        get("/hospitais/v1/opcoes")
      end

      # Lista os centros de informação toxicológica.
      #
      # +state+ vira +uf+ e só é enviado quando presente.
      #
      # @param state [String, nil] sigla da UF
      # @return [Array<Hash>] unidades do CIATOX
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example CIATOX do Piauí
      #   BrasilAPI::Hospital.ciatox(state: "PI")
      # @see https://brasilapi.com.br/docs#tag/HOSPITAIS
      def ciatox(state: nil)
        get("/hospitais/v1/ciatox", { uf: state })
      end

      # Busca um estabelecimento pelo código CNES.
      #
      # @param cnes [String, Integer] código CNES
      # @return [Hash] dados cadastrais do estabelecimento
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o CNES não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Hospital.find_by_cnes("2726998")
      # @see https://brasilapi.com.br/docs#tag/HOSPITAIS
      def find_by_cnes(cnes)
        get("/hospitais/v1/cnes/#{cnes}")
      end

      # Lista os estados que têm estabelecimentos cadastrados.
      #
      # @return [Array<Hash>] sigla e quantidade por UF
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Hospital.states
      # @see https://brasilapi.com.br/docs#tag/HOSPITAIS
      def states
        get("/hospitais/v1/estados")
      end
    end
  end
end
