# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Falha ao consultar a BrasilAPI.
  #
  # +Timeout+ não traz código HTTP. As demais subclasses preenchem +status+.
  class Error < StandardError
    # Código HTTP da resposta.
    #
    # @return [Integer, nil]
    attr_reader :status

    # Corpo da resposta, já interpretado quando é JSON.
    #
    # @return [Hash, Array, String, nil]
    attr_reader :body

    # Campo +type+ devolvido pela BrasilAPI.
    #
    # @return [String, nil]
    attr_reader :type

    # @param message [String, nil] texto exibido por +Exception#message+
    # @param status [Integer, nil] código HTTP
    # @param body [Hash, Array, String, nil] corpo da resposta
    # @param type [String, nil] classificação devolvida pela BrasilAPI
    def initialize(message = nil, status: nil, body: nil, type: nil)
      @status = status
      @body = body
      @type = type
      super(message)
    end
  end

  # A BrasilAPI respondeu 404.
  class NotFound < Error; end

  # A BrasilAPI respondeu 400.
  class BadRequest < Error; end

  # A BrasilAPI respondeu 5xx.
  class ServerError < Error; end

  # A conexão estourou +open_timeout+ ou +read_timeout+.
  class Timeout < Error; end
end
