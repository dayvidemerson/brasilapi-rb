# frozen_string_literal: true

require "json"
require "net/http"

module BrasilAPI
  class Base
    BASE_URL = "https://brasilapi.com.br/api"
    class << self
      def get(path, params = {})
        uri = URI("#{BASE_URL}#{path}")
        uri.query = URI.encode_www_form(params) unless params.empty?

        response = Net::HTTP.get_response(uri)

        case status_for(response)
        when 200
          parsed_body(response)
        when 404
          raise BrasilAPI::NotFound
        else
          raise BrasilAPI::Error
        end
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
