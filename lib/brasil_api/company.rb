# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Cadastro de pessoa jurídica na Receita Federal.
  #
  # @see https://brasilapi.com.br/docs#tag/CNPJ
  class Company < Base
    class << self
      # Busca uma empresa pelo CNPJ.
      #
      # @param documentation [String] CNPJ, com ou sem máscara
      # @return [Hash] razão social, situação cadastral e endereço
      # @raise [BrasilAPI::BadRequest] quando o CNPJ é inválido
      # @raise [BrasilAPI::NotFound] quando o CNPJ não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::Company.find_by_cnpj("19131243000197")
      # @see https://brasilapi.com.br/docs#tag/CNPJ
      def find_by_cnpj(documentation)
        get("/cnpj/v1/#{documentation}")
      end
    end
  end
end
