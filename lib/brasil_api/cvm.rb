# frozen_string_literal: true

module BrasilAPI
  class CVM < Base
    class << self
      def all
        get("/cvm/corretoras/v1")
      end

      def find_by_cnpj(cnpj)
        get("/cvm/corretoras/v1/#{cnpj}")
      end
    end
  end
end
