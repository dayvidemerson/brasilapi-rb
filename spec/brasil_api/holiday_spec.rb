# frozen_string_literal: true

RSpec.describe BrasilAPI::Holiday do
  describe ".by_year" do
    let(:year) { 2023 }
    let(:other_year) { 2024 }
    let(:invalid_year) { 0 }

    let(:holidays2024) { JSON.parse(File.read("spec/fixtures/holidays/2024.json")) }

    it "does not raise error" do
      VCR.use_cassette("holidays/by_year/2023") do
        expect { described_class.by_year(year) }.not_to raise_error
      end
    end

    it "returns the google info" do
      VCR.use_cassette("holidays/by_year/2024") do
        expect(described_class.by_year(other_year)).to eq(holidays2024)
      end
    end

    it "raise error not found" do
      VCR.use_cassette("holidays/by_year/invalid") do
        expect { described_class.by_year(invalid_year) }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
