# frozen_string_literal: true

module BrasilAPI
  class Status < Base
    class << self
      def check
        get("/status/v1")
      end
    end
  end
end
