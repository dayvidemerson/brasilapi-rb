# frozen_string_literal: true

module BrasilAPI
  class IGPM < Base
    class << self
      def all
        get("/indices/igpm/v1")
      end

      def last(limit)
        get("/indices/igpm/v1/ultimos", { limit: limit })
      end

      def between(initial_date, final_date)
        get(
          "/indices/igpm/v1/intervalo",
          { initial_date: format_date(initial_date), final_date: format_date(final_date) }
        )
      end
    end
  end
end
