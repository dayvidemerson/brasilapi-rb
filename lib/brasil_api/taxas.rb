# frozen_string_literal: true

module BrasilAPI
  class Taxas < Base
    class << self
      def all
        get("/taxas/v1")
      end

      def find_by_name(name)
        get("/taxas/v1/#{name}")
      end
    end
  end
end
