# frozen_string_literal: true

module BrasilAPI
  class NCM < Base
    class << self
      def search_ncm(code=nil)
        get("/ncm/v1", {:search => code})
      end
    end
  end
end