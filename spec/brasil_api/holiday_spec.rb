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

    it "does not send uf when the state is omitted" do
      VCR.turned_off do
        stub_request(:get, "https://brasilapi.com.br/api/feriados/v1/2024").to_return(status: 200, body: "[]")
        described_class.by_year(2024)

        expect(a_request(:get, "https://brasilapi.com.br/api/feriados/v1/2024")).to have_been_made
      end
    end

    it "returns state holidays" do
      VCR.use_cassette("holidays/by_year/sao_paulo") do
        holiday = described_class.by_year(2024, state: "SP").find { |item| item["type"] == "state" }

        expect(holiday).to include("name" => "Aniversário da Cidade de São Paulo")
      end
    end

    it "rejects an invalid state" do
      VCR.use_cassette("holidays/by_year/invalid_state") do
        expect { described_class.by_year(2024, state: "XX") }.to raise_error(BrasilAPI::BadRequest)
      end
    end
  end
end
