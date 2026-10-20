# frozen_string_literal: true

RSpec.describe BrasilAPI::Status do
  describe ".check" do
    it "returns the service status" do
      VCR.use_cassette("status/check/success") do
        expect(described_class.check).to include("status" => "ok")
      end
    end
  end
end
