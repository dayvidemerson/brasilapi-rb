# frozen_string_literal: true

RSpec.describe BrasilAPI::CVM::Fund do
  describe ".all" do
    it "returns a page of funds" do
      VCR.use_cassette("cvm/funds/all/page") do
        page = described_class.all(page: 1, size: 1)

        expect(page["data"]).to include(a_hash_including("cnpj" => "00.000.684/0001-21"))
      end
    end
  end

  describe ".find_by_cnpj" do
    it "returns the fund" do
      VCR.use_cassette("cvm/funds/find/deutsche") do
        fund = described_class.find_by_cnpj("00000684000121")

        expect(fund).to include("codigo_cvm" => "19")
      end
    end

    it "accepts a formatted cnpj" do
      VCR.use_cassette("cvm/funds/find/deutsche") do
        fund = described_class.find_by_cnpj("00.000.684/0001-21")

        expect(fund).to include("cnpj" => "00.000.684/0001-21")
      end
    end

    it "raises not found" do
      VCR.use_cassette("cvm/funds/find/not_found") do
        expect { described_class.find_by_cnpj("00000000000000") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
