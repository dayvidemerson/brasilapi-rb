# frozen_string_literal: true

module BrasilAPI
  class Solar < Base
    class << self
      def incidence(location)
        get("/solar/v1", { location: location })
      end
    end
  end
end
