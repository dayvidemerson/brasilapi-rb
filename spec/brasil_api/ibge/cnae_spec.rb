# frozen_string_literal: true

RSpec.describe BrasilAPI::IBGE::CNAE do
  describe ".classes" do
    it "returns the classes" do
      VCR.use_cassette("ibge/cnae/classes") do
        expect(described_class.classes).to include(a_hash_including("id" => "01113"))
      end
    end
  end

  describe ".find_class" do
    it "returns the class" do
      VCR.use_cassette("ibge/cnae/class") do
        expect(described_class.find_class("01113")).to include("descricao" => "CULTIVO DE CEREAIS")
      end
    end

    it "raises not found" do
      VCR.use_cassette("ibge/cnae/class_not_found") do
        expect { described_class.find_class("00000") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end

  describe ".find_division" do
    it "returns the classes of the division" do
      VCR.use_cassette("ibge/cnae/division") do
        expect(described_class.find_division("01")).to include(a_hash_including("id" => "01113"))
      end
    end
  end

  describe ".find_group" do
    it "returns the classes of the group" do
      VCR.use_cassette("ibge/cnae/group") do
        expect(described_class.find_group("011")).to include(a_hash_including("id" => "01113"))
      end
    end
  end
end
