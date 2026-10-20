# frozen_string_literal: true

module BrasilAPI
  class CID10 < Base
    class << self
      def all
        get("/oms/cid10/v1")
      end

      def find_by_code(code)
        get("/oms/cid10/v1/#{code}")
      end
    end
  end
end
