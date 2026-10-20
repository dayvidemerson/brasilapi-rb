# frozen_string_literal: true

module BrasilAPI
  class Holiday < Base
    class << self
      def by_year(year, state: nil)
        get("/feriados/v1/#{year}", { uf: state })
      end
    end
  end
end
