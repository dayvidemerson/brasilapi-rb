# frozen_string_literal: true

RSpec.describe BrasilAPI::NCM do
  describe ".all" do
    it "returns the nomenclature" do
      VCR.use_cassette("ncm/all/success") do
        expect(described_class.all).to include(a_hash_including("codigo" => "01"))
      end
    end
  end

  describe ".search" do
    it "returns matching codes" do
      VCR.use_cassette("ncm/search/coffee") do
        expect(described_class.search("cafe")).to include(a_hash_including("codigo" => "09.01"))
      end
    end

    it "returns an empty list when nothing matches" do
      VCR.use_cassette("ncm/search/empty") do
        expect(described_class.search("zzzzzzzznotfound")).to eq([])
      end
    end
  end

  describe ".find_by_code" do
    it "returns the code" do
      VCR.use_cassette("ncm/find_by_code/horses") do
        expect(described_class.find_by_code("01012100")).to include("codigo" => "0101.21.00")
      end
    end
  end
end
