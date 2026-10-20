# frozen_string_literal: true

RSpec.describe BrasilAPI::IBPT do
  describe ".version" do
    it "returns the current table version" do
      VCR.use_cassette("ibpt/version/success") do
        expect(described_class.version).to include("versao" => "24.2.A")
      end
    end
  end

  describe ".ncm" do
    it "returns the rates of a state" do
      VCR.use_cassette("ibpt/ncm/piaui") do
        expect(described_class.ncm("PI")).to include(a_hash_including("codigo" => "01012100"))
      end
    end

    it "returns one code" do
      VCR.use_cassette("ibpt/ncm/horses") do
        expect(described_class.ncm("SP", "01012100")).to include("descricao" => "Cavalos reprodutores,de raca pura")
      end
    end

    it "accepts an exception" do
      VCR.use_cassette("ibpt/ncm/exception") do
        rate = described_class.ncm("PI", "02109100", exception: "01")

        expect(rate).to include("ex" => "01")
      end
    end

    it "rejects an invalid state" do
      VCR.use_cassette("ibpt/ncm/invalid_state") do
        expect { described_class.ncm("XX", "01012100") }.to raise_error(BrasilAPI::BadRequest)
      end
    end
  end

  describe ".nbs" do
    it "returns the rates of a state" do
      VCR.use_cassette("ibpt/nbs/sao_paulo") do
        expect(described_class.nbs("SP")).to include(a_hash_including("codigo" => "101011000"))
      end
    end

    it "returns one code" do
      VCR.use_cassette("ibpt/nbs/construction") do
        rate = described_class.nbs("SP", "101011000")

        expect(rate).to include("codigo" => "101011000")
      end
    end
  end

  describe ".lc116" do
    it "returns the rates of a state" do
      VCR.use_cassette("ibpt/lc116/sao_paulo") do
        expect(described_class.lc116("SP")).to include(a_hash_including("codigo" => "0101"))
      end
    end

    it "returns one code" do
      VCR.use_cassette("ibpt/lc116/systems") do
        expect(described_class.lc116("SP", "0101")).to include("codigo" => "0101")
      end
    end

    it "raises not found" do
      VCR.use_cassette("ibpt/lc116/not_found") do
        expect { described_class.lc116("SP", "1.01") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
