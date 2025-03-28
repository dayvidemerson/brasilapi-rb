# frozen_string_literal: true

module BrasilAPI
  class PIX < Base
    class << self
      def all
        get("/pix/v1/participants")
      end
    end
  end
end
