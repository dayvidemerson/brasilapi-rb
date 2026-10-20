# frozen_string_literal: true

module BrasilAPI
  class BusinessDays < Base
    class << self
      def between(start_date, end_date, include_national_holidays: nil)
        get(
          "/diasuteis/v1",
          {
            dataInicial: format_date(start_date),
            dataFinal: format_date(end_date),
            incluirFeriadosNacionais: include_national_holidays
          }
        )
      end
    end
  end
end
