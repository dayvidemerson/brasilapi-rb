# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Metadados de livros a partir do ISBN.
  #
  # @see https://brasilapi.com.br/docs#tag/ISBN
  class ISBN < Base
    class << self
      # Busca um livro pelo ISBN.
      #
      # A BrasilAPI valida ISBNs brasileiros (+978+ seguido de +65+ ou +85+).
      # +providers+ vazio omite a query. Valores aceitos: +"cbl"+,
      # +"mercado-editorial"+, +"open-library"+ e +"google-books"+.
      #
      # @param code [String] ISBN-13, com ou sem hífen
      # @param providers [Array<String>] fontes consultadas, separadas por vírgula na API
      # @return [Hash] título, autores e editora
      # @raise [BrasilAPI::BadRequest] quando o ISBN não segue o padrão brasileiro
      # @raise [BrasilAPI::NotFound] quando nenhuma fonte encontra o livro
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Akira, volume 1
      #   BrasilAPI::ISBN.search("9788545702870", providers: ["open-library"])
      # @see https://brasilapi.com.br/docs#tag/ISBN
      def search(code, providers: [])
        return get("/isbn/v1/#{code}") if providers.empty?

        get("/isbn/v1/#{code}", providers: providers.join(","))
      end
    end
  end
end
