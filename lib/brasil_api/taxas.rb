# frozen_string_literal: true

module BrasilAPI
  class Taxas < Base
    class << self
<<<<<<< HEAD
      def rates(name=nil)
        return get("/taxas/v1") if name.nil?
=======
      def all
        get("/taxas/v1")
      end

      def find_by_name(name)
>>>>>>> 8333a3c (ajustes na nomeclatura)
        get("/taxas/v1/#{name}")
      end
    end
  end
end
