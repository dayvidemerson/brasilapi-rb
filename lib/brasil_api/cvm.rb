# frozen_string_literal: true

module BrasilAPI
  class CVM < Base
    class << self
      def all(state: nil)
        get("/cvm/corretoras/v1", { uf: state })
      end

      def find_by_cnpj(cnpj)
        get("/cvm/corretoras/v1/#{cnpj}")
      end
    end

    class Fund < Base
      class << self
        def all(page: nil, size: nil)
          get("/cvm/fundos/v1", { page: page, size: size })
        end

        def find_by_cnpj(cnpj)
          get("/cvm/fundos/v1/#{cnpj.to_s.gsub(/\D/, "")}")
        end
      end
    end
  end
end
