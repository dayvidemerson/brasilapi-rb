# frozen_string_literal: true

module BrasilAPI
  class B3 < Base
    class << self
      def stocks
        get("/tickers/b3/acoes/v1")
      end

      def funds(type)
        get("/tickers/b3/fundos/v1/#{type}")
      end
    end
  end
end
