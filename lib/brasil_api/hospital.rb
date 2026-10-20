# frozen_string_literal: true

module BrasilAPI
  class Hospital < Base
    LIST_PARAMS = {
      vertical: :vertical,
      state: :uf,
      city: :municipio,
      service: :atendimento,
      query: :q,
      limit: :limit,
      offset: :offset
    }.freeze

    NEARBY_PARAMS = {
      zip_code: :cep,
      latitude: :latitude,
      longitude: :longitude,
      city: :municipio,
      state: :uf,
      radius: :raio_km,
      vertical: :vertical,
      service: :atendimento,
      limit: :limit,
      offset: :offset
    }.freeze

    class << self
      def all(**filters)
        get("/hospitais/v1", translate(filters, LIST_PARAMS))
      end

      def nearby(**filters)
        get("/hospitais/v1/proximos", translate(filters, NEARBY_PARAMS))
      end

      def options
        get("/hospitais/v1/opcoes")
      end

      def ciatox(state: nil)
        get("/hospitais/v1/ciatox", { uf: state })
      end

      def find_by_cnes(cnes)
        get("/hospitais/v1/cnes/#{cnes}")
      end

      def states
        get("/hospitais/v1/estados")
      end
    end
  end
end
