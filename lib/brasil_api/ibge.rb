# frozen_string_literal: true

module BrasilAPI
  class IBGE < Base
    class << self
      def states
        get("/ibge/uf/v1")
      end

      def find_state_by_code(code)
        get("/ibge/uf/v1/#{code}")
      end

      def cities_by_state(state_abbr, provider = [])
        return get("/ibge/municipios/v1/#{state_abbr}") if provider.empty?
        get("/ibge/municipios/v1/#{state_abbr}", {:providers => provider.join(",")})
      end
    end
  end
end
