# frozen_string_literal: true

RSpec.describe BrasilAPI::Company do
  describe ".find_by_cnpj" do
    let(:meta_cnpj) { "13347016000117" }
    let(:google_cnpj) { "06990590000123" }
    let(:invalid_cnpj) { "00000000000000" }

    let(:google_info) { JSON.parse(File.read("spec/fixtures/companies/google.json")) }

    it "does not raise error" do
      VCR.use_cassette("company/find_by_cnpj/meta") do
        expect { described_class.find_by_cnpj(meta_cnpj) }.not_to raise_error
      end
    end

    it "returns the google info" do
      VCR.use_cassette("company/find_by_cnpj/google") do
        expect(described_class.find_by_cnpj(google_cnpj)).to eq(google_info)
      end
    end

    it "raise error not found" do
      VCR.use_cassette("company/find_by_cnpj/not_found") do
        expect { described_class.find_by_cnpj(invalid_cnpj) }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
