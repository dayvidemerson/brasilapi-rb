# frozen_string_literal: true

module BrasilAPI
  class IBPT < Base
    class << self
      def version
        get("/ibpt/versao/v1")
      end

      def ncm(state, code = nil, exception: nil)
        lookup("ncm", state, code, exception)
      end

      def nbs(state, code = nil, exception: nil)
        lookup("nbs", state, code, exception)
      end

      def lc116(state, code = nil, exception: nil)
        lookup("lc116", state, code, exception)
      end

      private

      def lookup(kind, state, code, exception)
        path = ["/ibpt/#{kind}/v1", state, code].compact.join("/")
        get(path, { ex: exception })
      end
    end
  end
end
