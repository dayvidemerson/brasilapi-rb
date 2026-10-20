# frozen_string_literal: true

RSpec.describe BrasilAPI::Geolocation do
  describe ".reverse" do
    it "returns the city" do
      VCR.use_cassette("geolocation/reverse/sao_paulo") do
        place = described_class.reverse(-23.55, -46.63)

        expect(place).to include("country" => "Brasil")
      end
    end

    it "accepts a language" do
      VCR.use_cassette("geolocation/reverse/sao_paulo_en") do
        place = described_class.reverse(-23.55, -46.63, language: "en")

        expect(place).to include("country" => "Brazil")
      end
    end

    it "rejects an invalid position" do
      VCR.use_cassette("geolocation/reverse/invalid") do
        expect { described_class.reverse("x", "y") }.to raise_error(BrasilAPI::BadRequest)
      end
    end
  end
end
