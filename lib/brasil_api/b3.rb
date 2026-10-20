# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Ações e fundos listados na B3.
  #
  # @see https://brasilapi.com.br/docs#tag/TICKERS
  class B3 < Base
    class << self
      # Lista as ações negociadas na B3.
      #
      # @return [Array<Hash>] ticker, empresa e segmento de cada ação
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::B3.stocks
      # @see https://brasilapi.com.br/docs#tag/TICKERS
      def stocks
        get("/tickers/b3/acoes/v1")
      end

      # Lista os fundos de um tipo da B3.
      #
      # Tipos aceitos: +"FII"+, +"SETORIAL"+, +"FIAGRO-FII"+, +"FIAGRO-FIDC"+,
      # +"FIAGRO-FIP"+, +"FIP"+ e +"FIA"+.
      #
      # @param type [String] tipo do fundo
      # @return [Array<Hash>] sigla e nome de cada fundo
      # @raise [BrasilAPI::BadRequest] quando o tipo é inválido
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Fundos setoriais
      #   BrasilAPI::B3.funds("SETORIAL")
      # @see https://brasilapi.com.br/docs#tag/TICKERS
      def funds(type)
        get("/tickers/b3/fundos/v1/#{type}")
      end
    end
  end
end
