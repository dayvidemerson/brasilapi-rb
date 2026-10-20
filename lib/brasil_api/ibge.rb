# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Estados, municípios, regiões e CNAE do IBGE.
  #
  # @see https://brasilapi.com.br/docs#tag/IBGE
  class IBGE < Base
    class << self
      # Lista as unidades federativas.
      #
      # @return [Array<Hash>] sigla, nome e região de cada UF
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::IBGE.states
      # @see https://brasilapi.com.br/docs#tag/IBGE
      def states
        get("/ibge/uf/v1")
      end

      # Busca uma unidade federativa pelo código ou pela sigla.
      #
      # @param code [String, Integer] código IBGE ou sigla, por exemplo +"PI"+
      # @return [Hash] dados da UF
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a UF não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::IBGE.find_state_by_code("PI")
      # @see https://brasilapi.com.br/docs#tag/IBGE
      def find_state_by_code(code)
        get("/ibge/uf/v1/#{code}")
      end

      # Lista os municípios de uma UF.
      #
      # +providers+ vazio omite a query. Valores aceitos: +"dados-abertos-br"+,
      # +"gov"+ e +"wikipedia"+.
      #
      # @param state_abbr [String] sigla da UF
      # @param providers [Array<String>] fontes consultadas, separadas por vírgula na API
      # @return [Array<Hash>] nome e código de cada município
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a UF não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Municípios do Piauí
      #   BrasilAPI::IBGE.cities_by_state("PI", providers: ["gov"])
      # @see https://brasilapi.com.br/docs#tag/IBGE
      def cities_by_state(state_abbr, providers: [])
        return get("/ibge/municipios/v1/#{state_abbr}") if providers.empty?

        get("/ibge/municipios/v1/#{state_abbr}", providers: providers.join(","))
      end

      # Lista as cinco regiões do Brasil.
      #
      # @return [Array<Hash>] código, sigla e nome de cada região
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::IBGE.regions
      # @see https://brasilapi.com.br/docs#tag/IBGE
      def regions
        get("/ibge/regioes/v1")
      end

      # Busca uma região pelo código IBGE.
      #
      # @param code [String, Integer] código da região, de 1 a 5
      # @return [Hash] sigla e nome da região
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a região não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Região Norte
      #   BrasilAPI::IBGE.find_region_by_code(1)
      # @see https://brasilapi.com.br/docs#tag/IBGE
      def find_region_by_code(code)
        get("/ibge/regioes/v1/#{code}")
      end

      # Lista as unidades federativas de uma região.
      #
      # @param code [String, Integer] código da região, de 1 a 5
      # @return [Array<Hash>] UFs da região
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a região não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Estados do Norte
      #   BrasilAPI::IBGE.states_by_region(1)
      # @see https://brasilapi.com.br/docs#tag/IBGE
      def states_by_region(code)
        get("/ibge/uf/v1/regiao/#{code}")
      end
    end

    # Classificação Nacional de Atividades Econômicas.
    #
    # @see https://brasilapi.com.br/docs#tag/IBGE
    class CNAE < Base
      class << self
        # Lista as classes CNAE.
        #
        # @return [Array<Hash>] código e descrição de cada classe
        # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
        # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
        # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
        # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
        # @raise [BrasilAPI::Error] em outras respostas de erro
        # @example
        #   BrasilAPI::IBGE::CNAE.classes
        # @see https://brasilapi.com.br/docs#tag/IBGE
        def classes
          get("/ibge/cnae/v1/classes")
        end

        # Busca uma classe CNAE pelo código.
        #
        # @param code [String, Integer] código da classe, por exemplo +"01113"+
        # @return [Hash] descrição da classe e do grupo
        # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
        # @raise [BrasilAPI::NotFound] quando a classe não existe
        # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
        # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
        # @raise [BrasilAPI::Error] em outras respostas de erro
        # @example Cultivo de cereais
        #   BrasilAPI::IBGE::CNAE.find_class("01113")
        # @see https://brasilapi.com.br/docs#tag/IBGE
        def find_class(code)
          get("/ibge/cnae/v1/classes/#{code}")
        end

        # Busca uma divisão CNAE pelo código.
        #
        # @param code [String, Integer] código da divisão, por exemplo +"01"+
        # @return [Hash] descrição da divisão
        # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
        # @raise [BrasilAPI::NotFound] quando a divisão não existe
        # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
        # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
        # @raise [BrasilAPI::Error] em outras respostas de erro
        # @example Agricultura, pecuária e serviços relacionados
        #   BrasilAPI::IBGE::CNAE.find_division("01")
        # @see https://brasilapi.com.br/docs#tag/IBGE
        def find_division(code)
          get("/ibge/cnae/v1/divisoes/#{code}")
        end

        # Busca um grupo CNAE pelo código.
        #
        # @param code [String, Integer] código do grupo, por exemplo +"011"+
        # @return [Hash] descrição do grupo
        # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
        # @raise [BrasilAPI::NotFound] quando o grupo não existe
        # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
        # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
        # @raise [BrasilAPI::Error] em outras respostas de erro
        # @example Produção de lavouras temporárias
        #   BrasilAPI::IBGE::CNAE.find_group("011")
        # @see https://brasilapi.com.br/docs#tag/IBGE
        def find_group(code)
          get("/ibge/cnae/v1/grupos/#{code}")
        end
      end
    end
  end
end
