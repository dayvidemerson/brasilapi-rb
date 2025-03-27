# frozen_string_literal: true

module BrasilAPI
  class PIX < Base
    class << self
      def get_participants
        get("/pix/v1/participants")
      end
    end
  end
end
