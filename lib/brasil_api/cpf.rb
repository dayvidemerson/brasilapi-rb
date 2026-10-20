# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Validação de CPF.
  #
  # A resposta não traz nome nem dados pessoais: apenas se o número é válido
  # e a região fiscal associada.
  #
  # @see https://brasilapi.com.br/docs#tag/CPF
  class CPF < Base
    class << self
      # Verifica se um CPF tem dígitos válidos.
      #
      # A BrasilAPI descarta pontuação antes de validar.
      #
      # @param cpf [String] CPF, com ou sem máscara
      # @return [Hash] +isValid+, região fiscal (+rf+) e UFs (+ufs+)
      # @raise [BrasilAPI::BadRequest] quando o valor não tem 11 dígitos
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example CPF com máscara
      #   BrasilAPI::CPF.find("000.000.000-00")
      # @see https://brasilapi.com.br/docs#tag/CPF
      def find(cpf)
        get("/cpf/v1/#{cpf}")
      end
    end
  end
end
