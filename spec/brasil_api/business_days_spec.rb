# frozen_string_literal: true

require "date"

RSpec.describe BrasilAPI::BusinessDays do
  describe ".between" do
    let(:business_days) do
      %w[2024-01-02 2024-01-03 2024-01-04 2024-01-05 2024-01-08 2024-01-09 2024-01-10]
    end

    it "lists the business days" do
      VCR.use_cassette("business_days/between/january") do
        result = described_class.between("2024-01-01", "2024-01-10")

        expect(result["diasUteis"]).to eq(business_days)
      end
    end

    it "accepts dates" do
      VCR.use_cassette("business_days/between/january") do
        result = described_class.between(Date.new(2024, 1, 1), Date.new(2024, 1, 10))

        expect(result["diasUteis"]).to eq(business_days)
      end
    end

    it "can ignore national holidays" do
      VCR.use_cassette("business_days/between/with_holidays") do
        result = described_class.between("2024-01-01", "2024-01-10", include_national_holidays: false)

        expect(result["diasUteis"]).to eq(["2024-01-01", *business_days])
      end
    end
  end
end
