# frozen_string_literal: true

RSpec.describe BrasilAPI::Bank do
  describe ".all" do
    let(:brazil_bank) do
      {
        "ispb" => "00000000",
        "name" => "BCO DO BRASIL S.A.",
        "code" => 1,
        "fullName" => "Banco do Brasil S.A."
      }
    end

    it "does not raise error" do
      VCR.use_cassette("bank/all/success") do
        expect { described_class.all }.not_to raise_error
      end
    end

    it "returns an array" do
      VCR.use_cassette("bank/all/success") do
        expect(described_class.all).to be_a(Array)
      end
    end

    it "returns 'Banco do Brasil'" do
      VCR.use_cassette("bank/all/success") do
        expect(described_class.all).to include(brazil_bank)
      end
    end

    it "raise error" do
      VCR.use_cassette("bank/all/internal_error") do
        expect { described_class.all }.to raise_error(BrasilAPI::Error)
      end
    end
  end

  describe ".find_by_code" do
    let(:brazil_bank_code) { 1 }
    let(:inter_bank_code) { 77 }

    let(:inter_bank) do
      {
        "ispb" => "00416968",
        "name" => "BANCO INTER",
        "code" => inter_bank_code,
        "fullName" => "Banco Inter S.A."
      }
    end

    it "does not raise error" do
      VCR.use_cassette("bank/get/brazil_bank") do
        expect { described_class.find_by_code(brazil_bank_code) }.not_to raise_error
      end
    end

    it "returns a inter bank" do
      VCR.use_cassette("bank/all/inter_bank") do
        expect(described_class.find_by_code(inter_bank_code)).to eq(inter_bank)
      end
    end

    it "raise error not found" do
      VCR.use_cassette("bank/all/not_found") do
        expect { described_class.find_by_code(0) }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
