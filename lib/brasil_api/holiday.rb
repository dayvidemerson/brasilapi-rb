# frozen_string_literal: true

module BrasilAPI
  class Holiday < Base
    class << self
      def by_year(year)
        get("/feriados/v1/#{year}")
      end
    end
  end
end
