# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Tabelas do Instituto Brasileiro de Planejamento e Tributação.
  #
  # @see https://brasilapi.com.br/docs#tag/IBPT
  class IBPT < Base
    class << self
      # Informa a versão publicada das tabelas IBPT.
      #
      # @return [Hash] versão vigente
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::IBPT.version
      # @see https://brasilapi.com.br/docs#tag/IBPT
      def version
        get("/ibpt/versao/v1")
      end

      # Consulta a tabela NCM do IBPT em uma UF.
      #
      # Sem +code+, devolve a tabela inteira da UF. +exception+ vira o parâmetro +ex+.
      #
      # @param state [String] sigla da UF
      # @param code [String, nil] código NCM de oito dígitos
      # @param exception [String, nil] exceção da TIPI, por exemplo +"01"+
      # @return [Hash, Array<Hash>] alíquotas do item ou a tabela da UF
      # @raise [BrasilAPI::BadRequest] quando a UF ou o código é inválido
      # @raise [BrasilAPI::NotFound] quando o código não existe na UF
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example NCM de cavalos em São Paulo
      #   BrasilAPI::IBPT.ncm("SP", "01012100")
      # @see https://brasilapi.com.br/docs#tag/IBPT
      def ncm(state, code = nil, exception: nil)
        lookup("ncm", state, code, exception)
      end

      # Consulta a tabela NBS do IBPT em uma UF.
      #
      # Sem +code+, devolve a tabela inteira da UF. O código NBS tem nove dígitos.
      #
      # @param state [String] sigla da UF
      # @param code [String, nil] código NBS
      # @param exception [String, nil] exceção tributária (+ex+)
      # @return [Hash, Array<Hash>] alíquotas do item ou a tabela da UF
      # @raise [BrasilAPI::BadRequest] quando a UF ou o código é inválido
      # @raise [BrasilAPI::NotFound] quando o código não existe na UF
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::IBPT.nbs("SP", "101011000")
      # @see https://brasilapi.com.br/docs#tag/IBPT
      def nbs(state, code = nil, exception: nil)
        lookup("nbs", state, code, exception)
      end

      # Consulta a tabela da LC 116 do IBPT em uma UF.
      #
      # Sem +code+, devolve a tabela inteira da UF. O código tem quatro dígitos, sem ponto.
      #
      # @param state [String] sigla da UF
      # @param code [String, nil] código da LC 116, por exemplo +"0101"+
      # @param exception [String, nil] exceção tributária (+ex+)
      # @return [Hash, Array<Hash>] alíquotas do item ou a tabela da UF
      # @raise [BrasilAPI::BadRequest] quando a UF ou o código é inválido
      # @raise [BrasilAPI::NotFound] quando o código não existe na UF
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::IBPT.lc116("SP", "0101")
      # @see https://brasilapi.com.br/docs#tag/IBPT
      def lc116(state, code = nil, exception: nil)
        lookup("lc116", state, code, exception)
      end

      private

      # Monta +/ibpt/{tipo}/v1/{uf}/{codigo}+ e envia a exceção em +ex+.
      #
      # @api private
      # @param kind [String] +"ncm"+, +"nbs"+ ou +"lc116"+
      # @param state [String] sigla da UF
      # @param code [String, nil] código do item
      # @param exception [String, nil] exceção tributária
      # @return [Hash, Array<Hash>]
      # @raise [BrasilAPI::Error]
      def lookup(kind, state, code, exception)
        path = ["/ibpt/#{kind}/v1", state, code].compact.join("/")
        get(path, { ex: exception })
      end
    end
  end
end
