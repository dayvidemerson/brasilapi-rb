# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Tempo limite das requisições HTTP.
  class Configuration
    # Tempo limite padrão, em segundos.
    DEFAULT_TIMEOUT = 10

    # Tempo limite de abertura e de leitura, em segundos.
    #
    # @return [Numeric]
    attr_accessor :timeout

    # Aplica {DEFAULT_TIMEOUT}.
    def initialize
      @timeout = DEFAULT_TIMEOUT
    end
  end

  class << self
    # Altera a configuração do cliente.
    #
    # @yieldparam config [BrasilAPI::Configuration] configuração atual
    # @return [void]
    # @example Trinta segundos de timeout
    #   BrasilAPI.configure { |config| config.timeout = 30 }
    def configure
      yield config
    end

    # Configuração usada pelas requisições.
    #
    # @return [BrasilAPI::Configuration]
    def config
      @config ||= Configuration.new
    end

    # Volta o tempo limite para o padrão.
    #
    # @return [BrasilAPI::Configuration]
    # @example
    #   BrasilAPI.reset_config!
    def reset_config!
      @config = Configuration.new
    end
  end
end
