# frozen_string_literal: true

RSpec.describe BrasilAPI::RegistroBR do
  describe ".whois" do
    it "returns a registered domain" do
      VCR.use_cassette("registrobr/whois/google") do
        expect(described_class.whois("google.com.br")).to include("status" => "REGISTERED")
      end
    end

    it "returns an available domain" do
      VCR.use_cassette("registrobr/whois/available") do
        expect(described_class.whois("livrexyz123.com.br")).to include("status" => "AVAILABLE")
      end
    end
  end
end
