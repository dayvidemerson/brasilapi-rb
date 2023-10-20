# frozen_string_literal: true

module BrasilAPI
  class Bank < Base
    class << self
      def all
        get("/banks/v1")
      end

      def find_by_code(code)
        get("/banks/v1/#{code}")
      end
    end
  end
end
