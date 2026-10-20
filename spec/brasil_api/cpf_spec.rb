# frozen_string_literal: true

RSpec.describe BrasilAPI::CPF do
  describe ".find" do
    it "rejects a digit-only check sequence" do
      VCR.use_cassette("cpf/find/digits") do
        expect(described_class.find("00000000000")).to eq({ "isValid" => false })
      end
    end

    it "accepts punctuation" do
      VCR.use_cassette("cpf/find/punctuation") do
        expect(described_class.find("000.000.000-00")).to eq({ "isValid" => false })
      end
    end

    it "rejects a value that is not numeric" do
      VCR.use_cassette("cpf/find/invalid") do
        expect { described_class.find("abc") }.to raise_error(BrasilAPI::BadRequest)
      end
    end
  end
end
