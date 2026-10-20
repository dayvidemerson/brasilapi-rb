# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Tabelas de preço de veículos da FIPE.
  #
  # +reference_table+ vira o parâmetro +tabela_referencia+ e some da query quando +nil+.
  #
  # @see https://brasilapi.com.br/docs#tag/FIPE
  class FIPE < Base
    class << self
      # Lista as marcas de um tipo de veículo.
      #
      # Sem +vehicle_type+, devolve as marcas de todos os tipos.
      #
      # @param vehicle_type [String, nil] +"carros"+, +"motos"+ ou +"caminhoes"+
      # @param reference_table [Integer, nil] código da tabela de referência
      # @return [Array<Hash>] nome e código de cada marca
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o tipo de veículo não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Marcas de carros na tabela 290
      #   BrasilAPI::FIPE.vehicle_brands("carros", 290)
      # @see https://brasilapi.com.br/docs#tag/FIPE
      def vehicle_brands(vehicle_type = nil, reference_table = nil)
        suffix = vehicle_type ? "/#{vehicle_type}" : ""
        get("/fipe/marcas/v1#{suffix}", { tabela_referencia: reference_table })
      end

      # Lista os anos de um modelo.
      #
      # @param vehicle_type [String] +"carros"+, +"motos"+ ou +"caminhoes"+
      # @param brand_code [String, Integer] código da marca
      # @param model_code [String, Integer] código do modelo
      # @param reference_table [Integer, nil] código da tabela de referência
      # @return [Array<Hash>] anos disponíveis para o modelo
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando marca ou modelo não existem
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Anos do VW Gol
      #   BrasilAPI::FIPE.vehicle_years("carros", 59, 5585)
      # @see https://brasilapi.com.br/docs#tag/FIPE
      def vehicle_years(vehicle_type, brand_code, model_code, reference_table = nil)
        get(
          "/fipe/anos/v1/#{vehicle_type}/#{brand_code}/#{model_code}",
          { tabela_referencia: reference_table }
        )
      end

      # Detalha um veículo em um ano específico.
      #
      # @param vehicle_type [String] +"carros"+, +"motos"+ ou +"caminhoes"+
      # @param brand_code [String, Integer] código da marca
      # @param model_code [String, Integer] código do modelo
      # @param year_code [String] código do ano, por exemplo +"2013-3"+
      # @param reference_table [Integer, nil] código da tabela de referência
      # @return [Hash] preço, combustível e código FIPE
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a combinação não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Gol 2013
      #   BrasilAPI::FIPE.vehicle_details("carros", 59, 5585, "2013-3")
      # @see https://brasilapi.com.br/docs#tag/FIPE
      def vehicle_details(vehicle_type, brand_code, model_code, year_code, reference_table = nil)
        get(
          "/fipe/detalhes/v1/#{vehicle_type}/#{brand_code}/#{model_code}/#{year_code}",
          { tabela_referencia: reference_table }
        )
      end

      # Consulta o preço pelo código FIPE.
      #
      # @param vehicle_code [String] código FIPE, por exemplo +"005329-5"+
      # @param reference_table [Integer, nil] código da tabela de referência
      # @return [Array<Hash>] preço nas tabelas consultadas
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o código FIPE não existe
      # @raise [BrasilAPI::ServerError] quando a fonte da FIPE está indisponível
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::FIPE.vehicle_price("005329-5")
      # @see https://brasilapi.com.br/docs#tag/FIPE
      def vehicle_price(vehicle_code, reference_table = nil)
        get("/fipe/preco/v1/#{vehicle_code}", { tabela_referencia: reference_table })
      end

      # Lista as tabelas de referência publicadas pela FIPE.
      #
      # @return [Array<Hash>] código e mês de cada tabela
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a fonte da FIPE está indisponível
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::FIPE.fipe_tables
      # @see https://brasilapi.com.br/docs#tag/FIPE
      def fipe_tables
        get("/fipe/tabelas/v1")
      end

      # Lista os modelos de uma marca.
      #
      # @param vehicle_type [String] +"carros"+, +"motos"+ ou +"caminhoes"+
      # @param brand_code [String, Integer] código da marca
      # @param reference_table [Integer, nil] código da tabela de referência
      # @return [Array<Hash>] modelos da marca
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a marca não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Modelos Volkswagen na tabela 290
      #   BrasilAPI::FIPE.list_vehicles("carros", 59, 290)
      # @see https://brasilapi.com.br/docs#tag/FIPE
      def list_vehicles(vehicle_type, brand_code, reference_table = nil)
        get("/fipe/veiculos/v1/#{vehicle_type}/#{brand_code}", { tabela_referencia: reference_table })
      end
    end
  end
end
