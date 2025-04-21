# frozen_string_literal: true

module BrasilAPI
  class NCM < Base
    class << self
      def all
        get("/ncm/v1")
      end

      def search(code)
        get("/ncm/v1", { search: code })
      end

      def find_by_code(code)
        get("/ncm/v1/#{code}")
      end
    end
  end
end
