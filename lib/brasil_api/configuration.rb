# frozen_string_literal: true

module BrasilAPI
  class Configuration
    DEFAULT_TIMEOUT = 10

    attr_accessor :timeout

    def initialize
      @timeout = DEFAULT_TIMEOUT
    end
  end

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end

    def reset_config!
      @config = Configuration.new
    end
  end
end
