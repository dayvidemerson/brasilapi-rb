require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  # config.default_cassette_options = { record: :all }
  config.hook_into :webmock
end
