# frozen_string_literal: true

RSpec.describe BrasilAPI::CPTEC do
  describe ".all" do
    let(:sao_felix_do_piaui) do
      {
        "nome" => "São Félix do Piauí",
        "id" => 4801,
        "estado" => "PI"
      }
    end

    it "does not raise error" do
      VCR.use_cassette("cptec/all/success") do
        expect { described_class.all }.not_to raise_error
      end
    end

    it "returns an array" do
      VCR.use_cassette("cvm/all/success") do
        expect(described_class.all).to be_a(Array)
      end
    end

    it "returns 'São Félix do Piauí'" do
      VCR.use_cassette("cvm/all/success") do
        expect(described_class.all).to include(sao_felix_do_piaui)
      end
    end
  end

  describe ".search_location" do
    let(:location) { "São Francisco" }

    let(:sao_francisco) do
      {
        "nome" => "São Francisco",
        "id" => 4807,
        "estado" => "SE"
      }
    end

    it "does not raise error" do
      VCR.use_cassette("cptec/search_location/sao_francisco") do
        expect { described_class.search_location(location) }.not_to raise_error
      end
    end

    it "returns an array" do
      VCR.use_cassette("cptec/search_location/sao_francisco") do
        expect(described_class.search_location(location)).to be_a(Array)
      end
    end

    it "returns 'São Francisco'" do
      VCR.use_cassette("cptec/search_location/sao_francisco") do
        expect(described_class.search_location(location)).to include(sao_francisco)
      end
    end

    it "raise error not found" do
      VCR.use_cassette("cptec/search_location/not_found") do
        expect { described_class.search_location("not_found") }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end

  describe ".city_weather" do
    let(:sao_felix_do_piaui_code) { 4801 }
    let(:days) { nil }
    let(:response) { described_class.city_weather(sao_felix_do_piaui_code, days) }

    context "when the weather returns only for today" do
      let(:sao_felix_do_piaui_weather) do
        {
          "cidade" => "São Félix do Piauí",
          "estado" => "PI",
          "atualizado_em" => "2025-07-03",
          "clima" => [
            {
              "data" => "2025-07-03",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 20,
              "max" => 34,
              "indice_uv" => 0
            }
          ]
        }
      end

      it "does not raise error" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui") do
          expect { response }.not_to raise_error
        end
      end

      it "returns an hash" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui") do
          expect(response).to be_a(Hash)
        end
      end

      it "returns weather for 'São Félix do Piauí'" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui") do
          expect(response).to include(sao_felix_do_piaui_weather)
        end
      end

      it "raise error not found" do
        VCR.use_cassette("cptec/city_weather/not_found") do
          expect { described_class.city_weather(0) }.to raise_error(BrasilAPI::NotFound)
        end
      end
    end

    context "when the weather returns for two days" do
      let(:days) { 2 }

      let(:sao_felix_do_piaui_weather) do
        {
          "cidade" => "São Félix do Piauí",
          "estado" => "PI",
          "atualizado_em" => "2025-07-03",
          "clima" => [
            {
              "data" => "2025-07-04",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 19,
              "max" => 34,
              "indice_uv" => 0
            },
            {
              "data" => "2025-07-05",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 21,
              "max" => 34,
              "indice_uv" => 0
            }
          ]
        }
      end

      it "does not raise error" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui_two_days") do
          expect { response }.not_to raise_error
        end
      end

      it "returns an hash" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui_two_days") do
          expect(response).to be_a(Hash)
        end
      end

      it "returns weather for 'São Félix do Piauí'" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui_two_days") do
          expect(response).to eq(sao_felix_do_piaui_weather)
        end
      end

      it "raise error not found" do
        VCR.use_cassette("cptec/city_weather/not_found") do
          expect { described_class.city_weather(0, days) }.to raise_error(BrasilAPI::NotFound)
        end
      end
    end

    context "when the weather returns for six days" do
      let(:days) { 6 }

      let(:sao_felix_do_piaui_weather) do
        {
          "cidade" => "São Félix do Piauí",
          "estado" => "PI",
          "atualizado_em" => "2025-07-03",
          "clima" => [
            {
              "data" => "2025-07-04",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 19,
              "max" => 34,
              "indice_uv" => 0
            },
            {
              "data" => "2025-07-05",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 21,
              "max" => 34,
              "indice_uv" => 0
            },
            {
              "data" => "2025-07-06",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 21,
              "max" => 34,
              "indice_uv" => 0
            },
            {
              "data" => "2025-07-07",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 21,
              "max" => 34,
              "indice_uv" => 0
            },
            {
              "data" => "2025-07-08",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 21,
              "max" => 34,
              "indice_uv" => 0
            },
            {
              "data" => "2025-07-09",
              "condicao" => "pn",
              "condicao_desc" => "Parcialmente Nublado",
              "min" => 21,
              "max" => 34,
              "indice_uv" => 0
            }
          ]
        }
      end

      it "does not raise error" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui_six_days") do
          expect { response }.not_to raise_error
        end
      end

      it "returns an hash" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui_six_days") do
          expect(response).to be_a(Hash)
        end
      end

      it "returns weather for 'São Félix do Piauí'" do
        VCR.use_cassette("cptec/city_weather/sao_felix_do_piaui_six_days") do
          expect(response).to include(sao_felix_do_piaui_weather)
        end
      end

      it "raise error not found" do
        VCR.use_cassette("cptec/city_weather/not_found") do
          expect { described_class.city_weather(0, days) }.to raise_error(BrasilAPI::NotFound)
        end
      end
    end

    context "when the weather returns for seven days" do
      let(:days) { 7 }

      it "raise error bad request" do
        VCR.use_cassette("cptec/city_weather/request_error") do
          expect { response }.to raise_error(BrasilAPI::Error)
        end
      end
    end
  end

  describe ".ocean_forecast" do
    let(:santo_amaro_do_maranhao_code) { 4701 }
    let(:days) { nil }
    let(:response) { described_class.ocean_forecast(santo_amaro_do_maranhao_code, days) }

    context "when the weather returns only for today" do
      let(:santo_amaro_do_maranhao_ocean) do
        {
          "cidade" => "Santo Amaro do Maranhão",
          "estado" => "MA",
          "atualizado_em" => "2025-07-03",
          "ondas" => [
            {
              "data" => "2025-07-03",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 9.1,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.3,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "03:00Z",
                  "vento" => 9.6,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "06:00Z",
                  "vento" => 9.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "09:00Z",
                  "vento" => 8.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "12:00Z",
                  "vento" => 8.8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "15:00Z",
                  "vento" => 9.7,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "18:00Z",
                  "vento" => 9,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "21:00Z",
                  "vento" => 8.2,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                }
              ]
            }
          ]
        }
      end

      it "does not raise error" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao") do
          expect { response }.not_to raise_error
        end
      end

      it "returns an hash" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao") do
          expect(response).to be_a(Hash)
        end
      end

      it "returns ocean forecast for 'Santo Amaro do Maranhão'" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao") do
          expect(response).to include(santo_amaro_do_maranhao_ocean)
        end
      end

      it "raise error not found" do
        VCR.use_cassette("cptec/ocean_forecast/not_found") do
          expect { described_class.ocean_forecast(0) }.to raise_error(BrasilAPI::NotFound)
        end
      end
    end

    context "when the weather returns for two days" do
      let(:days) { 2 }

      let(:santo_amaro_do_maranhao_ocean) do
        {
          "cidade" => "Santo Amaro do Maranhão",
          "estado" => "MA",
          "atualizado_em" => "2025-07-03",
          "ondas" => [
            {
              "data" => "2025-07-03",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 9.1,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.3,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "03:00Z",
                  "vento" => 9.6,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "06:00Z",
                  "vento" => 9.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "09:00Z",
                  "vento" => 8.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "12:00Z",
                  "vento" => 8.8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "15:00Z",
                  "vento" => 9.7,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "18:00Z",
                  "vento" => 9,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "21:00Z",
                  "vento" => 8.2,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                }
              ]
            },
            {
              "data" => "2025-07-04",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 7.8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "03:00Z",
                  "vento" => 8.1,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "06:00Z",
                  "vento" => 8,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "09:00Z",
                  "vento" => 7.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "12:00Z",
                  "vento" => 8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "15:00Z",
                  "vento" => 7.5,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "18:00Z",
                  "vento" => 7.7,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "21:00Z",
                  "vento" => 8,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                }
              ]
            }
          ]
        }
      end

      it "does not raise error" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao_two_days") do
          expect { response }.not_to raise_error
        end
      end

      it "returns an hash" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao_two_days") do
          expect(response).to be_a(Hash)
        end
      end

      it "returns ocean forecast for 'Santo Amaro do Maranhão'" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao_two_days") do
          expect(response).to include(santo_amaro_do_maranhao_ocean)
        end
      end

      it "raise error not found" do
        VCR.use_cassette("cptec/ocean_forecast/not_found") do
          expect { described_class.ocean_forecast(0, days) }.to raise_error(BrasilAPI::NotFound)
        end
      end
    end

    context "when the weather returns for six days" do
      let(:days) { 6 }

      let(:santo_amaro_do_maranhao_ocean) do
        {
          "cidade" => "Santo Amaro do Maranhão",
          "estado" => "MA",
          "atualizado_em" => "2025-07-03",
          "ondas" => [
            {
              "data" => "2025-07-03",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 9.1,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.3,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "03:00Z",
                  "vento" => 9.6,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "06:00Z",
                  "vento" => 9.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "09:00Z",
                  "vento" => 8.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "12:00Z",
                  "vento" => 8.8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "15:00Z",
                  "vento" => 9.7,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "18:00Z",
                  "vento" => 9,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "21:00Z",
                  "vento" => 8.2,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.7,
                  "direcao_onda" => "SSE",
                  "direcao_onda_desc" => "Sul-sudeste",
                  "agitation" => "Fraco"
                }
              ]
            },
            {
              "data" => "2025-07-04",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 7.8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "03:00Z",
                  "vento" => 8.1,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "06:00Z",
                  "vento" => 8,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "09:00Z",
                  "vento" => 7.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "12:00Z",
                  "vento" => 8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "15:00Z",
                  "vento" => 7.5,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "18:00Z",
                  "vento" => 7.7,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "21:00Z",
                  "vento" => 8,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                }
              ]
            },
            {
              "data" => "2025-07-05",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 7.5,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "03:00Z",
                  "vento" => 6.7,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "06:00Z",
                  "vento" => 6.8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.4,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "09:00Z",
                  "vento" => 6.7,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.4,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "12:00Z",
                  "vento" => 7,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.4,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "15:00Z",
                  "vento" => 7.1,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "18:00Z",
                  "vento" => 7.3,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "21:00Z",
                  "vento" => 7,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                }
              ]
            },
            {
              "data" => "2025-07-06",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 6.7,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "03:00Z",
                  "vento" => 6.9,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "06:00Z",
                  "vento" => 7,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.6,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "09:00Z",
                  "vento" => 6.1,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "12:00Z",
                  "vento" => 7.4,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "15:00Z",
                  "vento" => 6.6,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "18:00Z",
                  "vento" => 7.4,
                  "direcao_vento" => "ESE",
                  "direcao_vento_desc" => "Lés-sudeste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "21:00Z",
                  "vento" => 7.5,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                }
              ]
            },
            {
              "data" => "2025-07-07",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 7.1,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "03:00Z",
                  "vento" => 7.4,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "06:00Z",
                  "vento" => 7.4,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.4,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "09:00Z",
                  "vento" => 6.8,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.4,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "12:00Z",
                  "vento" => 8.1,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.4,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "15:00Z",
                  "vento" => 7.7,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.4,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "18:00Z",
                  "vento" => 8,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                },
                {
                  "hora" => "21:00Z",
                  "vento" => 8.2,
                  "direcao_vento" => "E",
                  "direcao_vento_desc" => "Leste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "S",
                  "direcao_onda_desc" => "Sul",
                  "agitation" => "Fraco"
                }
              ]
            },
            {
              "data" => "2025-07-08",
              "dados_ondas" => [
                {
                  "hora" => "00:00Z",
                  "vento" => 8.3,
                  "direcao_vento" => "ENE",
                  "direcao_vento_desc" => "Lés-nordeste",
                  "altura_onda" => 1.5,
                  "direcao_onda" => "N",
                  "direcao_onda_desc" => "Norte",
                  "agitation" => "Fraco"
                }
              ]
            }
          ]
        }
      end

      it "does not raise error" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao_six_days") do
          expect { response }.not_to raise_error
        end
      end

      it "returns an hash" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao_six_days") do
          expect(response).to be_a(Hash)
        end
      end

      it "returns ocean forecast for 'Santo Amaro do Maranhão'" do
        VCR.use_cassette("cptec/ocean_forecast/santo_amaro_do_maranhao_six_days") do
          expect(response).to include(santo_amaro_do_maranhao_ocean)
        end
      end

      it "raise error not found" do
        VCR.use_cassette("cptec/ocean_forecast/not_found") do
          expect { described_class.ocean_forecast(0, days) }.to raise_error(BrasilAPI::NotFound)
        end
      end
    end

    context "when the weather returns for seven days" do
      let(:days) { 7 }

      it "raise error bad request" do
        VCR.use_cassette("cptec/ocean_forecast/request_error") do
          expect { response }.to raise_error(BrasilAPI::Error)
        end
      end
    end
  end
end
