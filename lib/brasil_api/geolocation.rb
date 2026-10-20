# frozen_string_literal: true

module BrasilAPI
  class Geolocation < Base
    class << self
      def reverse(latitude, longitude, language: nil)
        get("/geolocation/v1", { latitude: latitude, longitude: longitude, language: language })
      end
    end
  end
end
