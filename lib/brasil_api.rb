# frozen_string_literal: true

require_relative "brasil_api/version"
require_relative "brasil_api/base"
require_relative "brasil_api/address"
require_relative "brasil_api/bank"
require_relative "brasil_api/company"
require_relative "brasil_api/cvm"
require_relative "brasil_api/holiday"
require_relative "brasil_api/ibge"
require_relative "brasil_api/cptec"
require_relative "brasil_api/fipe"
require_relative "brasil_api/isbn"
require_relative "brasil_api/ncm"
require_relative "brasil_api/pix"
require_relative "brasil_api/registrobr"
require_relative "brasil_api/taxas"

module BrasilAPI
  class Error < StandardError; end
  class NotFound < StandardError; end
end
