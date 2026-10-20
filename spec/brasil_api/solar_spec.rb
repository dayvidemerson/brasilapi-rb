# frozen_string_literal: true

RSpec.describe BrasilAPI::Solar do
  describe ".incidence" do
    it "returns the sun times" do
      VCR.use_cassette("solar/incidence/teresina") do
        expect(described_class.incidence("Teresina")).to include("sunrise", "sunset")
      end
    end

    it "rejects a missing location" do
      VCR.use_cassette("solar/incidence/missing") do
        expect { described_class.incidence(nil) }.to raise_error(BrasilAPI::BadRequest)
      end
    end
  end
end
