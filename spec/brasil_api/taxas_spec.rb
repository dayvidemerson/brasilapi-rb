# frozen_string_literal: true

RSpec.describe BrasilAPI::Taxas do
  describe ".all" do
    it "returns the rates" do
      VCR.use_cassette("taxas/all/success") do
        expect(described_class.all).to include(a_hash_including("nome" => "Selic"))
      end
    end
  end

  describe ".find_by_name" do
    it "returns selic" do
      VCR.use_cassette("taxas/find_by_name/selic") do
        expect(described_class.find_by_name("selic")).to include("nome" => "SELIC", "valor" => 13.75)
      end
    end

    it "raises not found" do
      VCR.use_cassette("taxas/find_by_name/not_found") do
        expect { described_class.find_by_name("NAOEXISTE") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
