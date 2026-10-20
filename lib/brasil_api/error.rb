# frozen_string_literal: true

module BrasilAPI
  class Error < StandardError
    attr_reader :status, :body, :type

    def initialize(message = nil, status: nil, body: nil, type: nil)
      @status = status
      @body = body
      @type = type
      super(message)
    end
  end

  class NotFound < Error; end

  class BadRequest < Error; end

  class ServerError < Error; end

  class Timeout < Error; end
end
