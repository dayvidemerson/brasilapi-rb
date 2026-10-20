# frozen_string_literal: true

module BrasilAPI
  class DDD < Base
    class << self
      def all
        get("/ddd/v1")
      end

      def find(ddd, version: 2)
        get("/ddd/v#{version}/#{ddd}")
      end

      def by_state(state)
        get("/ddd/uf/v1/#{state}")
      end
    end
  end
end
