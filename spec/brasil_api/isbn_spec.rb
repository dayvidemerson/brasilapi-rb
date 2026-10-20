# frozen_string_literal: true

RSpec.describe BrasilAPI::ISBN do
  describe ".search" do
    it "returns the book" do
      VCR.use_cassette("isbn/search/akira") do
        expect(described_class.search("9788545702870")).to include("title" => "Akira vol. 1")
      end
    end

    it "accepts providers" do
      VCR.use_cassette("isbn/search/akira_open_library") do
        book = described_class.search("9788545702870", providers: ["open-library"])

        expect(book).to include("title" => "Akira vol. 1")
      end
    end

    it "raises not found when the isbn does not exist" do
      VCR.use_cassette("isbn/search/not_found") do
        expect { described_class.search("9788500000003") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
