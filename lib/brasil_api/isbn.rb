# frozen_string_literal: true

module BrasilAPI
  class ISBN < Base
    class << self
      # https://brasilapi.com.br/api/isbn/v1/{isbn}
      def book_info(code, provider = [])
        return get("/isbn/v1/#{code}") if provider.empty?
        get("/isbn/v1/#{code}", {:providers => provider.join(",")})
      end
    end
  end
end