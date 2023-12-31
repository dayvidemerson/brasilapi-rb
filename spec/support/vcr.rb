# frozen_string_literal: true

require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.default_cassette_options = { record: :new_episodes }
  config.hook_into :webmock
end
