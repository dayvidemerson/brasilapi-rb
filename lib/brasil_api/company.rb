# frozen_string_literal: true

module BrasilAPI
  class Company < Base
    class << self
      def find_by_cnpj(documentation)
        get("/cnpj/v1/#{documentation}")
      end
    end
  end
end
