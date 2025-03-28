# frozen_string_literal: true

module BrasilAPI
  class FIPE < Base
    class << self

      # https://brasilapi.com.br/api/fipe/marcas/v1/{tipoVeiculo}
<<<<<<< HEAD
      def vehicle_brands(vehicle_type, reference_table = nil)
        get("/fipe/marcas/v1/#{vehicle_type}", {:tabela_referencia => reference_table })
      end

      # https://brasilapi.com.br/api/fipe/preco/v1/{codigoFipe}
      def vehicle_price(vehicle_code, reference_table = nil)
        get("/fipe/preco/v1/#{vehicle_code}", { :tabela_referencia => reference_table })
      end

      # https://brasilapi.com.br/api/fipe/tabelas/v1
      def fipe_tables()
=======
      def find_by_vehicle_brands(vehicle_type, reference_table = nil)
        get("/fipe/marcas/v1/#{vehicle_type}", { tabela_referencia: reference_table })
      end

      # https://brasilapi.com.br/api/fipe/preco/v1/{codigoFipe}
      def find_by_vehicle_price(vehicle_code, reference_table = nil)
        get("/fipe/preco/v1/#{vehicle_code}", { tabela_referencia: reference_table })
      end

      # https://brasilapi.com.br/api/fipe/tabelas/v1
      def all_fipe_tables
>>>>>>> 8333a3c (ajustes na nomeclatura)
        get("/fipe/tabelas/v1")
      end

      # https://brasilapi.com.br/api/fipe/veiculos/v1/{tipoVeiculo}/{codigoMarca}
      def list_vehicles(vehicle_type, brand_code, reference_table = nil)
        get("/fipe/veiculos/v1/#{vehicle_type}/#{brand_code}", { :tabela_referencia => reference_table })
      end

    end
  end
end