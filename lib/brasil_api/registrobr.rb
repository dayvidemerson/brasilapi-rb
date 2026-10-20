# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Disponibilidade de domínios +.br+ no Registro.br.
  #
  # @see https://brasilapi.com.br/docs#tag/REGISTRO-BR
  class RegistroBR < Base
    class << self
      # Consulta o status de um domínio +.br+.
      #
      # @param domain [String] domínio, por exemplo +"google.com.br"+
      # @return [Hash] status +"REGISTERED"+ ou +"AVAILABLE"+ e as datas conhecidas
      # @raise [BrasilAPI::BadRequest] quando o domínio é inválido
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::RegistroBR.whois("google.com.br")
      # @see https://brasilapi.com.br/docs#tag/REGISTRO-BR
      def whois(domain)
        get("/registrobr/v1/#{domain}")
      end
    end
  end
end
