# frozen_string_literal: true

module BrasilAPI
  class Taxas < Base
    class << self
      def taxs(name=nil)
        return get("/taxas/v1") if name.nil?
        get("/taxas/v1/#{name}")
      end
    end
  end
end
