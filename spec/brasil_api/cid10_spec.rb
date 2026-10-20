# frozen_string_literal: true

RSpec.describe BrasilAPI::CID10 do
  describe ".all" do
    it "returns the codes" do
      VCR.use_cassette("cid10/all/success") do
        expect(described_class.all).to include(a_hash_including("codigo" => "A00"))
      end
    end
  end

  describe ".find_by_code" do
    it "returns the code" do
      VCR.use_cassette("cid10/find_by_code/cholera") do
        expect(described_class.find_by_code("A00")).to include("codigo" => "A00", "nome" => "Cólera")
      end
    end

    it "raises not found" do
      VCR.use_cassette("cid10/find_by_code/not_found") do
        expect { described_class.find_by_code("ZZZZ") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
