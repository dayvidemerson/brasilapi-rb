# frozen_string_literal: true

require "json"
require "net/http"

module BrasilAPI
  class Base
    BASE_URL = "https://brasilapi.com.br/api"

    class << self
      def get(path)
        uri = URI("#{BASE_URL}#{path}")

        response = Net::HTTP.get_response(uri)

        {
          status: status_for(response),
          data: parsed_body(response)
        }
      end

      protected

      def status_for(response)
        status = {
          Net::HTTPOK => 200,
          Net::HTTPNotFound => 404
        }

        status[response.class]
      end

      def parsed_body(response)
        JSON.parse(response.body) if response.body
      end
    end
  end
end
