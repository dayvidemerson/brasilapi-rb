# frozen_string_literal: true

RSpec.describe BrasilAPI::B3 do
  describe ".stocks" do
    it "returns the stock tickers" do
      VCR.use_cassette("b3/stocks/success") do
        expect(described_class.stocks).to include(a_hash_including("issuing_company" => "UQMU"))
      end
    end
  end

  describe ".funds" do
    it "returns the fund tickers" do
      VCR.use_cassette("b3/funds/setorial") do
        expect(described_class.funds("SETORIAL")).to include(a_hash_including("acronym" => "FDES"))
      end
    end

    it "rejects an invalid type" do
      VCR.use_cassette("b3/funds/invalid") do
        expect { described_class.funds("FI") }.to raise_error(BrasilAPI::BadRequest)
      end
    end
  end
end
