# frozen_string_literal: true

RSpec.describe BrasilAPI::PIX do
  describe ".all" do
    it "returns the participants" do
      VCR.use_cassette("pix/all/success") do
        expect(described_class.all).to include(a_hash_including("ispb" => "24313102"))
      end
    end
  end
end
