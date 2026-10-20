# frozen_string_literal: true

RSpec.describe BrasilAPI do
  def silence_warnings
    verbose = $VERBOSE
    $VERBOSE = nil
    yield
  ensure
    $VERBOSE = verbose
  end

  it "has a version number" do
    silence_warnings { load File.expand_path("../lib/brasil_api/version.rb", __dir__) }

    expect(described_class::VERSION).to eq("0.9.0")
  end

  it "loads the brasilapi entry point" do
    require "brasilapi"

    expect(BrasilAPI::Bank).to be < BrasilAPI::Base
  end
end
