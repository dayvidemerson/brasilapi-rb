# frozen_string_literal: true

module BrasilAPI
  class ISBN < Base
    class << self
      def search(code, providers: [])
        return get("/isbn/v1/#{code}") if providers.empty?

        get("/isbn/v1/#{code}", providers: providers.join(","))
      end
    end
  end
end
