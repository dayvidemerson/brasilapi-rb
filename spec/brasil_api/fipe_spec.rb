# frozen_string_literal: true

RSpec.describe BrasilAPI::FIPE do
  before do
    stub_request(:get, /brasilapi\.com\.br/).to_return(status: 200, body: "[]")
  end

  describe "without a reference table" do
    it "omits tabela_referencia from vehicle_brands" do
      VCR.turned_off do
        described_class.vehicle_brands("carros")

        expect(a_request(:get, "https://brasilapi.com.br/api/fipe/marcas/v1/carros")).to have_been_made
      end
    end

    it "omits tabela_referencia from vehicle_price" do
      VCR.turned_off do
        described_class.vehicle_price("001234-5")

        expect(a_request(:get, "https://brasilapi.com.br/api/fipe/preco/v1/001234-5")).to have_been_made
      end
    end

    it "omits tabela_referencia from list_vehicles" do
      VCR.turned_off do
        described_class.list_vehicles("carros", 21)

        expect(a_request(:get, "https://brasilapi.com.br/api/fipe/veiculos/v1/carros/21")).to have_been_made
      end
    end
  end

  describe "with a reference table" do
    it "sends tabela_referencia" do
      VCR.turned_off do
        described_class.vehicle_brands("carros", 290)
        url = "https://brasilapi.com.br/api/fipe/marcas/v1/carros?tabela_referencia=290"

        expect(a_request(:get, url)).to have_been_made
      end
    end

    it "sends tabela_referencia for every brand" do
      VCR.turned_off do
        described_class.vehicle_brands(nil, 290)
        url = "https://brasilapi.com.br/api/fipe/marcas/v1?tabela_referencia=290"

        expect(a_request(:get, url)).to have_been_made
      end
    end

    it "sends tabela_referencia for vehicle years" do
      VCR.turned_off do
        described_class.vehicle_years("carros", 59, 5585, 290)
        url = "https://brasilapi.com.br/api/fipe/anos/v1/carros/59/5585?tabela_referencia=290"

        expect(a_request(:get, url)).to have_been_made
      end
    end

    it "sends tabela_referencia for vehicle details" do
      VCR.turned_off do
        described_class.vehicle_details("carros", 59, 5585, "2013-3", 290)
        url = "https://brasilapi.com.br/api/fipe/detalhes/v1/carros/59/5585/2013-3?tabela_referencia=290"

        expect(a_request(:get, url)).to have_been_made
      end
    end
  end

  describe "without a vehicle type" do
    it "requests every brand" do
      VCR.turned_off do
        described_class.vehicle_brands

        expect(a_request(:get, "https://brasilapi.com.br/api/fipe/marcas/v1")).to have_been_made
      end
    end
  end

  describe "years, details and tables" do
    it "requests years without a reference table" do
      VCR.turned_off do
        described_class.vehicle_years("carros", 59, 5585)

        expect(a_request(:get, "https://brasilapi.com.br/api/fipe/anos/v1/carros/59/5585")).to have_been_made
      end
    end

    it "requests details without a reference table" do
      VCR.turned_off do
        described_class.vehicle_details("carros", 59, 5585, "2013-3")

        expect(a_request(:get, "https://brasilapi.com.br/api/fipe/detalhes/v1/carros/59/5585/2013-3")).to have_been_made
      end
    end

    it "requests the reference tables" do
      VCR.turned_off do
        described_class.fipe_tables

        expect(a_request(:get, "https://brasilapi.com.br/api/fipe/tabelas/v1")).to have_been_made
      end
    end
  end
end
