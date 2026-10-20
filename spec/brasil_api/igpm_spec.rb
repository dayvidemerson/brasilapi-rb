# frozen_string_literal: true

require "date"

RSpec.describe BrasilAPI::IGPM do
  describe ".all" do
    it "returns the series" do
      VCR.use_cassette("igpm/all/success") do
        expect(described_class.all.first).to include("value", "date")
      end
    end
  end

  describe ".last" do
    it "returns the latest values" do
      VCR.use_cassette("igpm/last/two") do
        expect(described_class.last(2).size).to eq(2)
      end
    end

    it "rejects an invalid limit" do
      VCR.use_cassette("igpm/last/invalid") do
        expect { described_class.last(0) }.to raise_error(BrasilAPI::BadRequest)
      end
    end
  end

  describe ".between" do
    it "returns the range" do
      VCR.use_cassette("igpm/between/january") do
        series = described_class.between("2024-01-01", "2024-02-01")

        expect(series).to include(a_hash_including("date" => "2024-01-01T00:00:00.000Z"))
      end
    end

    it "accepts dates" do
      VCR.use_cassette("igpm/between/january") do
        series = described_class.between(Date.new(2024, 1, 1), Date.new(2024, 2, 1))

        expect(series.first).to include("value")
      end
    end
  end
end
