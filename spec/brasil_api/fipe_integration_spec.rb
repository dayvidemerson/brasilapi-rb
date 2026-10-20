# frozen_string_literal: true

RSpec.describe BrasilAPI::FIPE do
  describe ".vehicle_brands" do
    it "returns brands of a vehicle type" do
      VCR.use_cassette("fipe/vehicle_brands/cars") do
        expect(described_class.vehicle_brands("carros")).to include(a_hash_including("nome" => "VW - VolksWagen"))
      end
    end

    it "returns brands of every vehicle type" do
      VCR.use_cassette("fipe/vehicle_brands/all") do
        expect(described_class.vehicle_brands).to include(a_hash_including("nome" => "Acura"))
      end
    end

    it "accepts a reference table" do
      VCR.use_cassette("fipe/vehicle_brands/reference_table") do
        brands = described_class.vehicle_brands(nil, 290)

        expect(brands).to include(a_hash_including("nome" => "Acura"))
      end
    end
  end

  describe ".list_vehicles" do
    it "returns vehicles of a brand" do
      VCR.use_cassette("fipe/list_vehicles/vw") do
        expect(described_class.list_vehicles("carros", 59)).to include(a_hash_including("valor" => "5585"))
      end
    end

    it "accepts a reference table" do
      VCR.use_cassette("fipe/list_vehicles/vw_reference") do
        vehicles = described_class.list_vehicles("carros", 59, 290)

        expect(vehicles).to include(a_hash_including("valor" => "5585"))
      end
    end
  end

  describe ".vehicle_years" do
    it "returns the years of a model" do
      VCR.use_cassette("fipe/vehicle_years/amarok") do
        expect(described_class.vehicle_years("carros", 59, 5585)).to include(a_hash_including("valor" => "2013-3"))
      end
    end
  end

  describe ".vehicle_details" do
    it "returns the price and details" do
      VCR.use_cassette("fipe/vehicle_details/amarok") do
        details = described_class.vehicle_details("carros", 59, 5585, "2013-3")

        expect(details).to include("codigoFipe" => "005329-5", "anoModelo" => 2013)
      end
    end
  end

  describe ".vehicle_price" do
    it "surfaces the upstream failure" do
      VCR.use_cassette("fipe/vehicle_price/upstream_error") do
        expect { described_class.vehicle_price("005329-5") }.to raise_error(BrasilAPI::ServerError)
      end
    end
  end

  describe ".fipe_tables" do
    it "surfaces the upstream failure" do
      VCR.use_cassette("fipe/tables/upstream_error") do
        expect { described_class.fipe_tables }.to raise_error(BrasilAPI::ServerError)
      end
    end
  end
end
