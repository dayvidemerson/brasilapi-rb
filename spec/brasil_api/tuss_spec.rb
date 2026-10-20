# frozen_string_literal: true

RSpec.describe BrasilAPI::TUSS do
  def request_filtered_search
    stub_request(:get, /brasilapi\.com\.br/).to_return(status: 200, body: '{"items":[]}')
    described_class.search(**search_filters)
  end

  def filtered_search_url
    "https://brasilapi.com.br/api/tuss/v1/search?q=consulta&name=Consulta&tuss=10101012" \
      "&match=exact&sort=name&order=asc&fields=name&limit=1&offset=0"
  end

  def search_filters
    { query: "consulta", name: "Consulta", code: "10101012", match: "exact", sort: "name", order: "asc",
      fields: "name", limit: 1, offset: 0 }
  end

  describe ".all" do
    it "returns a page of procedures" do
      VCR.use_cassette("tuss/all/page") do
        page = described_class.all(name: "Consulta", limit: 1)

        expect(page["items"]).to include(a_hash_including("tuss" => "10101012"))
      end
    end
  end

  describe ".find_by_code" do
    it "returns the procedure" do
      VCR.use_cassette("tuss/find_by_code/consult") do
        expect(described_class.find_by_code("10101012")).to include("tuss" => "10101012")
      end
    end

    it "raises not found" do
      VCR.use_cassette("tuss/find_by_code/not_found") do
        expect { described_class.find_by_code("000") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end

  describe ".search" do
    it "returns the matches" do
      VCR.use_cassette("tuss/search/consult") do
        page = described_class.search(query: "consulta", limit: 1)

        expect(page).to include("total" => 31)
      end
    end

    it "forwards the filters" do
      VCR.turned_off { request_filtered_search }

      expect(a_request(:get, filtered_search_url)).to have_been_made
    end
  end

  describe ".autocomplete" do
    it "returns suggestions" do
      VCR.use_cassette("tuss/autocomplete/cons") do
        suggestions = described_class.autocomplete(query: "cons", limit: 2)

        expect(suggestions).to include(a_hash_including("tuss" => "10101012"))
      end
    end
  end
end
