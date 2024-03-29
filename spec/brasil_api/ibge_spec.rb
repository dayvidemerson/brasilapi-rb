# frozen_string_literal: true

RSpec.describe BrasilAPI::IBGE do
  describe ".states" do
    let(:states) { JSON.parse(File.read("spec/fixtures/ibge/states.json")) }

    it "does not raise error" do
      VCR.use_cassette("ibge/states/success") do
        expect { described_class.states }.not_to raise_error
      end
    end

    it "returns states from ibge" do
      VCR.use_cassette("ibge/states/success") do
        expect(described_class.states).to eq(states)
      end
    end
  end

  describe ".find_state_by_code" do
    let(:piaui_code) { 22 }
    let(:rio_de_janeiro_code) { "RJ" }
    let(:invalid_code) { 0 }
    let(:piaui_info) { JSON.parse(File.read("spec/fixtures/ibge/piaui_info.json")) }

    it "does not raise error" do
      VCR.use_cassette("ibge/find_state_by_code/rio_de_janeiro") do
        expect { described_class.find_state_by_code(rio_de_janeiro_code) }.not_to raise_error
      end
    end

    it "returns piaui info from ibge" do
      VCR.use_cassette("ibge/find_state_by_code/piaui") do
        expect(described_class.find_state_by_code(piaui_code)).to eq(piaui_info)
      end
    end

    it "returns error not found" do
      VCR.use_cassette("ibge/find_state_by_code/not_found") do
        expect { described_class.find_state_by_code(invalid_code) }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end

  describe ".cities_by_state" do
    let(:piaui_abbr) { "PI" }
    let(:sao_paulo_abbr) { "SP" }

    context "when does not choose the provider" do
      let(:invalid_abbr) { "AS" }
      let(:piaui_cities) { JSON.parse(File.read("spec/fixtures/ibge/piaui_cities.json")) }

      it "does not raise error" do
        VCR.use_cassette("ibge/cities_by_state/sao_paulo") do
          expect { described_class.cities_by_state(sao_paulo_abbr) }.not_to raise_error
        end
      end

      it "returns the cities from piaui" do
        VCR.use_cassette("ibge/cities_by_state/piaui") do
          expect(described_class.cities_by_state(piaui_abbr)).to eq(piaui_cities)
        end
      end

      it "returns error not found when state is invalid" do
        VCR.use_cassette("ibge/cities_by_state/not_found") do
          expect { described_class.cities_by_state(invalid_abbr) }.to raise_error(BrasilAPI::NotFound)
        end
      end
    end

    context "when choose provider" do
      let(:piaui_cities_gov) { JSON.parse(File.read("spec/fixtures/ibge/piaui_cities_gov.json")) }
      let(:providers) { ["gov"] }
      let(:invalid_providers) { ["correios"] }

      it "returns the cities from piaui when choose provider" do
        VCR.use_cassette("ibge/cities_by_state/piaui_gov") do
          expect(described_class.cities_by_state(piaui_abbr, providers: providers)).to eq(piaui_cities_gov)
        end
      end

      it "returns error internal when provider is invalid" do
        VCR.use_cassette("ibge/cities_by_state/internal") do
          expect do
            described_class.cities_by_state(sao_paulo_abbr, providers: invalid_providers)
          end.to raise_error(BrasilAPI::Error)
        end
      end
    end
  end
end
