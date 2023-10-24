# frozen_string_literal: true

RSpec.describe BrasilAPI::Address do
  describe ".find_by_zip_code" do
    let(:teresina_zip_code) { "64001100" }
    let(:parana_zip_code) { "80060000" }
    let(:invalid_zip_code) { "87654321" }

    let(:address_parana_info) { JSON.parse(File.read("spec/fixtures/addresses/parana_location.json")) }
    let(:address_teresina_info) { JSON.parse(File.read("spec/fixtures/addresses/teresina.json")) }

    it "does not raise error" do
      VCR.use_cassette("address/find_by_zip_code/teresina") do
        expect { described_class.find_by_zip_code(teresina_zip_code) }.not_to raise_error
      end
    end

    it "returns the address parana without location" do
      VCR.use_cassette("address/find_by_zip_code/teresina") do
        expect(described_class.find_by_zip_code(teresina_zip_code)).to eq(address_teresina_info)
      end
    end

    it "returns the address teresina with location" do
      VCR.use_cassette("address/find_by_zip_code/parana_location") do
        expect(described_class.find_by_zip_code(parana_zip_code, location: true)).to eq(address_parana_info)
      end
    end

    it "raise error not found" do
      VCR.use_cassette("address/find_by_zip_code/not_found") do
        expect { described_class.find_by_zip_code(invalid_zip_code) }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
