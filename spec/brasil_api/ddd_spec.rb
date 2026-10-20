# frozen_string_literal: true

RSpec.describe BrasilAPI::DDD do
  describe ".all" do
    it "returns the area codes of each state" do
      VCR.use_cassette("ddd/all/success") do
        expect(described_class.all).to include(a_hash_including("state" => "PI"))
      end
    end
  end

  describe ".find" do
    it "returns the states served by the area code" do
      VCR.use_cassette("ddd/find/sao_paulo_v2") do
        expect(described_class.find("11")).to include(a_hash_including("state" => "SP"))
      end
    end

    it "requests version 1" do
      VCR.use_cassette("ddd/find/piaui_v1") do
        expect(described_class.find("86", version: 1)).to include("state" => "PI")
      end
    end

    it "raises not found" do
      VCR.use_cassette("ddd/find/not_found") do
        expect { described_class.find("00") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end

  describe ".by_state" do
    it "returns the area codes of the state" do
      VCR.use_cassette("ddd/by_state/sao_paulo") do
        expect(described_class.by_state("SP")).to include(a_hash_including("ddd" => "11"))
      end
    end

    it "raises not found" do
      VCR.use_cassette("ddd/by_state/not_found") do
        expect { described_class.by_state("XX") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
