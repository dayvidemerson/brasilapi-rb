# frozen_string_literal: true

RSpec.describe BrasilAPI::Hospital do
  describe ".all" do
    it "filters the hospitals" do
      VCR.use_cassette("hospital/all/piaui") do
        page = described_class.all(state: "PI", city: "TERESINA", limit: 1)

        expect(page["items"]).to include(a_hash_including("cnes" => "2726998"))
      end
    end
  end

  describe ".nearby" do
    it "searches by zip code" do
      VCR.use_cassette("hospital/nearby/zip_code") do
        page = described_class.nearby(zip_code: "64001100", limit: 1)

        expect(page["items"].first).to include("cnes")
      end
    end

    it "searches by coordinates" do
      VCR.use_cassette("hospital/nearby/coordinates") do
        page = described_class.nearby(latitude: -5.09, longitude: -42.8, radius: 10, limit: 1)

        expect(page).to include("origem")
      end
    end
  end

  describe ".options" do
    it "returns the filter options" do
      VCR.use_cassette("hospital/options/success") do
        expect(described_class.options).to include("fonte")
      end
    end
  end

  describe ".ciatox" do
    it "lists the centers of a state" do
      VCR.use_cassette("hospital/ciatox/sao_paulo") do
        expect(described_class.ciatox(state: "SP")).to include("total")
      end
    end

    it "lists every center when the state is omitted" do
      VCR.use_cassette("hospital/ciatox/all") do
        expect(described_class.ciatox).to include("total")
      end
    end
  end

  describe ".find_by_cnes" do
    it "returns the hospital" do
      VCR.use_cassette("hospital/cnes/teresina") do
        hospital = described_class.find_by_cnes("2726998")

        expect(hospital["items"]).to include(a_hash_including("city" => "TERESINA"))
      end
    end

    it "raises not found" do
      VCR.use_cassette("hospital/cnes/not_found") do
        expect { described_class.find_by_cnes("0000000") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end

  describe ".states" do
    it "returns the states" do
      VCR.use_cassette("hospital/states/success") do
        expect(described_class.states).to include("total" => 27)
      end
    end
  end
end
