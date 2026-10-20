# frozen_string_literal: true

RSpec.describe BrasilAPI::Base do
  def capture_error
    yield
  rescue BrasilAPI::Error => e
    e
  end

  def http_start(timeout)
    ["brasilapi.com.br", 443, { use_ssl: true, open_timeout: timeout, read_timeout: timeout }]
  end

  def http_ok(body)
    response = Net::HTTPOK.new("1.1", "200", "OK")
    response.body = body
    response.instance_variable_set(:@read, true)
    response
  end

  describe "errors" do
    it "makes NotFound a BrasilAPI::Error" do
      expect(BrasilAPI::NotFound).to be < BrasilAPI::Error
    end

    it "makes BadRequest a BrasilAPI::Error" do
      expect(BrasilAPI::BadRequest).to be < BrasilAPI::Error
    end

    it "makes ServerError a BrasilAPI::Error" do
      expect(BrasilAPI::ServerError).to be < BrasilAPI::Error
    end

    it "makes Timeout a BrasilAPI::Error" do
      expect(BrasilAPI::Timeout).to be < BrasilAPI::Error
    end

    describe "404" do
      def error
        VCR.use_cassette("bank/find_by_code/not_found") do
          capture_error { described_class.get("/banks/v1/0") }
        end
      end

      it "is raised as NotFound and rescued as BrasilAPI::Error" do
        expect(error).to be_a(BrasilAPI::NotFound)
      end

      it "exposes the status" do
        expect(error.status).to eq(404)
      end

      it "exposes the message" do
        expect(error.message).to eq("Código bancário não encontrado")
      end

      it "exposes the type" do
        expect(error.type).to eq("BANK_CODE_NOT_FOUND")
      end
    end

    describe "400" do
      def error
        VCR.use_cassette("cptec/city_weather/request_error") do
          capture_error { described_class.get("/cptec/v1/clima/previsao/4801/7") }
        end
      end

      it "is a BadRequest" do
        expect(error).to be_a(BrasilAPI::BadRequest)
      end

      it "exposes the status" do
        expect(error.status).to eq(400)
      end

      it "exposes the message" do
        expect(error.message).to eq("Quantidade de dias inválida (mínimo 1 dia e máximo 14 dias)")
      end

      it "exposes the type" do
        expect(error.type).to eq("request_error")
      end

      it "keeps the parsed body" do
        expect(error.body).to include("name" => "INVALID_NUMBER_OF_DAYS")
      end
    end

    describe "500" do
      def error
        VCR.use_cassette("ibge/cities_by_state/internal") do
          capture_error { described_class.get("/ibge/municipios/v1/SP", { providers: "correios" }) }
        end
      end

      it "is a ServerError" do
        expect(error).to be_a(BrasilAPI::ServerError)
      end

      it "exposes the status" do
        expect(error.status).to eq(500)
      end

      it "exposes the message" do
        expect(error.message).to eq("Erro ao buscar UF.")
      end

      it "exposes the type" do
        expect(error.type).to eq("internal")
      end
    end

    it "accepts a 201 response" do
      VCR.turned_off do
        stub_request(:get, "https://brasilapi.com.br/api/banks/v1").to_return(status: 201, body: '[{"code":1}]')

        expect(described_class.get("/banks/v1")).to eq([{ "code" => 1 }])
      end
    end

    it "accepts an empty 204 response" do
      VCR.turned_off do
        stub_request(:get, "https://brasilapi.com.br/api/banks/v1").to_return(status: 204, body: "")

        expect(described_class.get("/banks/v1")).to be_nil
      end
    end

    it "accepts a success without a body" do
      response = Net::HTTPOK.new("1.1", "200", "OK")
      response.instance_variable_set(:@read, true)
      allow(Net::HTTP).to receive(:start).and_return(response)

      expect(described_class.get("/banks/v1")).to be_nil
    end

    describe "422" do
      def error
        VCR.turned_off do
          stub_request(:get, "https://brasilapi.com.br/api/banks/v1").to_return(
            status: 422,
            body: '{"message":"não processado","type":"unprocessable"}'
          )
          capture_error { described_class.get("/banks/v1") }
        end
      end

      it "stays a generic BrasilAPI::Error" do
        expect(error).to be_a(BrasilAPI::Error)
      end

      it "is not a BadRequest or ServerError" do
        expect(error.class).to eq(BrasilAPI::Error)
      end

      it "exposes the status" do
        expect(error.status).to eq(422)
      end

      it "exposes the message" do
        expect(error.message).to eq("não processado")
      end

      it "exposes the type" do
        expect(error.type).to eq("unprocessable")
      end
    end

    describe "empty error body" do
      def error
        VCR.turned_off do
          stub_request(:get, "https://brasilapi.com.br/api/banks/v1").to_return(status: 409, body: "")
          capture_error { described_class.get("/banks/v1") }
        end
      end

      it "uses the HTTP status as the message" do
        expect(error.message).to eq("HTTP 409")
      end

      it "keeps the empty body" do
        expect(error.body).to eq("")
      end

      it "has no type" do
        expect(error.type).to be_nil
      end
    end

    describe "missing error body" do
      def error
        response = Net::HTTPConflict.new("1.1", "409", "Conflict")
        response.instance_variable_set(:@read, true)
        allow(Net::HTTP).to receive(:start).and_return(response)
        capture_error { described_class.get("/banks/v1") }
      end

      it "uses the HTTP status as the message" do
        expect(error.message).to eq("HTTP 409")
      end

      it "has no body" do
        expect(error.body).to be_nil
      end
    end

    describe "non JSON 502" do
      def error
        VCR.turned_off do
          stub_request(:get, "https://brasilapi.com.br/api/banks/v1").to_return(status: 502, body: "bad gateway")
          capture_error { described_class.get("/banks/v1") }
        end
      end

      it "is a ServerError" do
        expect(error).to be_a(BrasilAPI::ServerError)
      end

      it "uses the raw body as the message" do
        expect(error.message).to eq("bad gateway")
      end

      it "keeps the raw body" do
        expect(error.body).to eq("bad gateway")
      end

      it "has no type" do
        expect(error.type).to be_nil
      end
    end
  end

  describe "timeout" do
    it "defaults to 10 seconds" do
      expect(BrasilAPI.config.timeout).to eq(10)
    end

    it "allows configuring the timeout" do
      BrasilAPI.configure { |config| config.timeout = 3 }

      expect(BrasilAPI.config.timeout).to eq(3)
    end

    it "applies open_timeout and read_timeout" do
      BrasilAPI.configure { |config| config.timeout = 4 }
      allow(Net::HTTP).to receive(:start).and_yield(instance_double(Net::HTTP, request: http_ok("[]")))
      described_class.get("/banks/v1")
      expect(Net::HTTP).to have_received(:start).with(*http_start(4))
    end

    it "wraps Net::OpenTimeout in BrasilAPI::Timeout" do
      allow(Net::HTTP).to receive(:start).and_raise(Net::OpenTimeout.new("execution expired"))

      expect { described_class.get("/banks/v1") }.to raise_error(BrasilAPI::Timeout, "execution expired")
    end

    it "keeps the original timeout as the cause" do
      allow(Net::HTTP).to receive(:start).and_raise(Net::ReadTimeout.new("execution expired"))

      expect(capture_error { described_class.get("/banks/v1") }.cause).to be_a(Net::ReadTimeout)
    end
  end

  describe "URL escaping" do
    before do
      stub_request(:get, /brasilapi\.com\.br/).to_return(status: 200, body: "[]")
    end

    it "encodes spaces and accents" do
      VCR.turned_off do
        described_class.get("/cptec/v1/cidade/São Francisco")

        expect(a_request(:get, "https://brasilapi.com.br/api/cptec/v1/cidade/S%C3%A3o%20Francisco")).to have_been_made
      end
    end

    it "encodes question marks inside a segment" do
      VCR.turned_off do
        described_class.get("/cptec/v1/cidade/a?b")

        expect(a_request(:get, "https://brasilapi.com.br/api/cptec/v1/cidade/a%3Fb")).to have_been_made
      end
    end

    it "encodes hashes inside a segment" do
      VCR.turned_off do
        described_class.get("/registrobr/v1/x#y")

        expect(a_request(:get, "https://brasilapi.com.br/api/registrobr/v1/x%23y")).to have_been_made
      end
    end
  end
end
