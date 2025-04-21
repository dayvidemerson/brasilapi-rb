# frozen_string_literal: true

module BrasilAPI
  class CPTEC < Base
    class << self

      def all
        get("/cptec/v1/cidade")
      end

      def search_location(city_name)
        get("/cptec/v1/cidade/#{city_name}")
      end

      def capital_weather()
        get("/cptec/v1/clima/capital")
      end

      def airport_weather(code)
        get("/cptec/v1/clima/aeroporto/#{code}")
      end

      def city_weather(city_code, days = nil)

        if days
          get("/cptec/v1/clima/previsao/#{city_code}/#{days}")
        else
          get("/cptec/v1/clima/previsao/#{city_code}")
        end

      end

      def ocean_forecast(city_code, days=nil)
        if days
          get("/cptec/v1/ondas/#{city_code}/#{days}")
        else
          get("/cptec/v1/ondas/#{city_code}")
        end
      end
    end
  end
end