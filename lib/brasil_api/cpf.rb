# frozen_string_literal: true

module BrasilAPI
  class CPF < Base
    class << self
      def find(cpf)
        get("/cpf/v1/#{cpf}")
      end
    end
  end
end
