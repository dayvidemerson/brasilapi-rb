# frozen_string_literal: true

module BrasilAPI
  class NCM < Base
    class << self
<<<<<<< HEAD
      def search_ncm(code=nil)
        get("/ncm/v1", {:search => code})
=======
      def all
        get("/ncm/v1")
      end

      def search(code)
        get("/ncm/v1", { search: code })
>>>>>>> 8333a3c (ajustes na nomeclatura)
      end

      def find_by_code(code)
        get("/ncm/v1/#{code}")
      end
    end
  end
end