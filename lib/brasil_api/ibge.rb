# frozen_string_literal: true

module BrasilAPI
  class IBGE < Base
    class << self
      def states
        get("/ibge/uf/v1")
      end

      def cities_by_state(state_abbr, providers: [])
        return get("/ibge/municipios/v1/#{state_abbr}") if providers.empty?

        providers_query = providers.join(",")
        get("/ibge/municipios/v1/#{state_abbr}?providers=#{providers_query}")
      end
    end
  end
end
