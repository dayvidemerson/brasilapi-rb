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
end
