# frozen_string_literal: true

module BrasilAPI
  class ISBN < Base
    class << self
      def search(code, provider = [])
        return get("/isbn/v1/#{code}") if provider.empty?
        get("/isbn/v1/#{code}", {:providers => provider.join(",")})
      end
    end
  end
end