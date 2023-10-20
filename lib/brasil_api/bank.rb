# frozen_string_literal: true

module BrasilAPI
  class Bank < Base
    class << self
      def all
        response = get("/banks/v1")

        raise BrasilAPI::Error if response[:status] != 200

        response[:data]
      end

      def find_by_code(code)
        get("/banks/v1/#{code}")
      end
    end
  end
end
