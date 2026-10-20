# frozen_string_literal: true

module BrasilAPI
  class TUSS < Base
    PARAMS = {
      query: :q,
      name: :name,
      code: :tuss,
      match: :match,
      sort: :sort,
      order: :order,
      fields: :fields,
      limit: :limit,
      offset: :offset
    }.freeze

    class << self
      def all(**filters)
        get("/tuss/v1", translate(filters, PARAMS))
      end

      def find_by_code(code)
        get("/tuss/v1/#{code}")
      end

      def search(**filters)
        get("/tuss/v1/search", translate(filters, PARAMS))
      end

      def autocomplete(**filters)
        get("/tuss/v1/autocomplete", translate(filters, PARAMS))
      end
    end
  end
end
