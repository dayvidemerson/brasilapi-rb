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

      def cities_by_state(state_abbr, providers: [])
        return get("/ibge/municipios/v1/#{state_abbr}") if providers.empty?

        get("/ibge/municipios/v1/#{state_abbr}", providers: providers.join(","))
      end

      def regions
        get("/ibge/regioes/v1")
      end

      def find_region_by_code(code)
        get("/ibge/regioes/v1/#{code}")
      end

      def states_by_region(code)
        get("/ibge/uf/v1/regiao/#{code}")
      end
    end

    class CNAE < Base
      class << self
        def classes
          get("/ibge/cnae/v1/classes")
        end

        def find_class(code)
          get("/ibge/cnae/v1/classes/#{code}")
        end

        def find_division(code)
          get("/ibge/cnae/v1/divisoes/#{code}")
        end

        def find_group(code)
          get("/ibge/cnae/v1/grupos/#{code}")
        end
      end
    end
  end
end
