# frozen_string_literal: true

module BrasilAPI
  class Address < Base
    class << self
      def find_by_zip_code(zip_code, location: false)
        return get("/cep/v2/#{zip_code}") if location

        get("/cep/v1/#{zip_code}")
      end

      def state_and_cities_by_area_code(area_code)
        get("/ddd/v1/#{area_code}")
      end
    end
  end
end
