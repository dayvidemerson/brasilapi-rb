# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Nomenclatura Comum do Mercosul.
  #
  # @see https://brasilapi.com.br/docs#tag/NCM
  class NCM < Base
    class << self
      # Lista todos os códigos NCM.
      #
      # @return [Array<Hash>] código e descrição de cada NCM
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::NCM.all
      # @see https://brasilapi.com.br/docs#tag/NCM
      def all
        get("/ncm/v1")
      end

      # Procura códigos NCM por texto ou por prefixo.
      #
      # @param code [String] termo de busca, por exemplo +"cafe"+
      # @return [Array<Hash>] NCMs que correspondem à busca
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando nada corresponde
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::NCM.search("cafe")
      # @see https://brasilapi.com.br/docs#tag/NCM
      def search(code)
        get("/ncm/v1", { search: code })
      end

      # Busca um NCM pelo código completo.
      #
      # @param code [String] código NCM de oito dígitos
      # @return [Hash] descrição e vigência do código
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o código não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Cavalos reprodutores de raça pura
      #   BrasilAPI::NCM.find_by_code("01012100")
      # @see https://brasilapi.com.br/docs#tag/NCM
      def find_by_code(code)
        get("/ncm/v1/#{code}")
      end
    end
  end
end
