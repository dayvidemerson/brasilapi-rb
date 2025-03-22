# frozen_string_literal: true

module BrasilAPI
  class RegistroBR < Base
    class << self
      def whois(domain)
        get("/registrobr/v1/#{domain}")
      end
    end
  end
end