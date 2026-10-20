# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Corretoras registradas na Comissão de Valores Mobiliários.
  #
  # @see https://brasilapi.com.br/docs#tag/CVM
  class CVM < Base
    class << self
      # Lista as corretoras, opcionalmente filtradas por UF.
      #
      # @param state [String, nil] sigla da UF; omitida quando +nil+
      # @return [Array<Hash>] corretoras e seus CNPJs
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Corretoras de São Paulo
      #   BrasilAPI::CVM.all(state: "SP")
      # @see https://brasilapi.com.br/docs#tag/CVM
      def all(state: nil)
        get("/cvm/corretoras/v1", { uf: state })
      end

      # Busca uma corretora pelo CNPJ.
      #
      # @param cnpj [String] CNPJ, com ou sem máscara
      # @return [Hash] dados da corretora
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o CNPJ não é de uma corretora
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::CVM.find_by_cnpj("74014747000135")
      # @see https://brasilapi.com.br/docs#tag/CVM
      def find_by_cnpj(cnpj)
        get("/cvm/corretoras/v1/#{cnpj}")
      end
    end

    # Fundos de investimento registrados na CVM.
    #
    # @see https://brasilapi.com.br/docs#tag/CVM
    class Fund < Base
      class << self
        # Lista fundos, com paginação opcional.
        #
        # @param page [Integer, nil] página, a partir de 1
        # @param size [Integer, nil] quantidade de itens na página
        # @return [Hash] página de fundos
        # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
        # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
        # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
        # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
        # @raise [BrasilAPI::Error] em outras respostas de erro
        # @example Primeira página, um item
        #   BrasilAPI::CVM::Fund.all(page: 1, size: 1)
        # @see https://brasilapi.com.br/docs#tag/CVM
        def all(page: nil, size: nil)
          get("/cvm/fundos/v1", { page: page, size: size })
        end

        # Busca um fundo pelo CNPJ.
        #
        # A BrasilAPI só aceita dígitos no caminho, então a máscara é removida.
        #
        # @param cnpj [String] CNPJ, com ou sem máscara
        # @return [Hash] dados do fundo
        # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
        # @raise [BrasilAPI::NotFound] quando o CNPJ não é de um fundo
        # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
        # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
        # @raise [BrasilAPI::Error] em outras respostas de erro
        # @example
        #   BrasilAPI::CVM::Fund.find_by_cnpj("00.000.684/0001-21")
        # @see https://brasilapi.com.br/docs#tag/CVM
        def find_by_cnpj(cnpj)
          get("/cvm/fundos/v1/#{cnpj.to_s.gsub(/\D/, "")}")
        end
      end
    end
  end
end
