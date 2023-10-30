# frozen_string_literal: true

require_relative "brasil_api/version"
require_relative "brasil_api/base"
require_relative "brasil_api/address"
require_relative "brasil_api/bank"
require_relative "brasil_api/company"
require_relative "brasil_api/holiday"

module BrasilAPI
  class Error < StandardError; end
  class NotFound < StandardError; end
end
