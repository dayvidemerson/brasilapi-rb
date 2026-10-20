# frozen_string_literal: true

require "date"

RSpec.describe BrasilAPI::Cambio do
  describe ".currencies" do
    it "returns the currencies" do
      VCR.use_cassette("cambio/currencies/success") do
        expect(described_class.currencies).to include(a_hash_including("simbolo" => "USD"))
      end
    end
  end

  describe ".quote" do
    it "accepts a date" do
      VCR.use_cassette("cambio/quote/usd") do
        quote = described_class.quote("USD", Date.new(2024, 1, 15))

        expect(quote["cotacoes"]).to be_an(Array)
      end
    end

    it "accepts a string date" do
      VCR.use_cassette("cambio/quote/usd") do
        quote = described_class.quote("USD", "2024-01-15")

        expect(quote).to include("cotacoes")
      end
    end

    it "rejects an unknown currency" do
      VCR.use_cassette("cambio/quote/invalid") do
        expect { described_class.quote("XXX", "2024-01-15") }.to raise_error(BrasilAPI::BadRequest)
      end
    end
  end
end
