# frozen_string_literal: true

module BrasilAPI
  class Cambio < Base
    class << self
      def currencies
        get("/cambio/v1/moedas")
      end

      def quote(currency, date)
        get("/cambio/v1/cotacao/#{currency}/#{format_date(date)}")
      end
    end
  end
end
