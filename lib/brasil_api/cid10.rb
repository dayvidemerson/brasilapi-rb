# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Classificação Internacional de Doenças, 10ª revisão.
  #
  # @see https://brasilapi.com.br/docs#tag/CID10
  class CID10 < Base
    class << self
      # Lista os capítulos, grupos e categorias do CID-10.
      #
      # @return [Array<Hash>] código e descrição de cada item
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::CID10.all
      # @see https://brasilapi.com.br/docs#tag/CID10
      def all
        get("/oms/cid10/v1")
      end

      # Busca uma categoria do CID-10 pelo código.
      #
      # @param code [String] código CID, por exemplo +"A00"+
      # @return [Hash] descrição da categoria
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o código não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Cólera
      #   BrasilAPI::CID10.find_by_code("A00")
      # @see https://brasilapi.com.br/docs#tag/CID10
      def find_by_code(code)
        get("/oms/cid10/v1/#{code}")
      end
    end
  end
end
