# frozen_string_literal: true

# Cliente Ruby da {https://brasilapi.com.br BrasilAPI}.
#
# @example Bancos participantes do STR
#   BrasilAPI::Bank.all
# @see https://brasilapi.com.br/docs
module BrasilAPI
  # Previsão do tempo e de ondas do CPTEC/INPE.
  #
  # @see https://brasilapi.com.br/docs#tag/CPTEC
  class CPTEC < Base
    class << self
      # Lista as cidades atendidas pelo CPTEC.
      #
      # @return [Array<Hash>] nome e código de cada cidade
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::CPTEC.all
      # @see https://brasilapi.com.br/docs#tag/CPTEC
      def all
        get("/cptec/v1/cidade")
      end

      # Procura cidades pelo nome.
      #
      # @param city_name [String] parte do nome da cidade
      # @return [Array<Hash>] cidades encontradas e seus códigos
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando nenhuma cidade corresponde
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::CPTEC.search_location("Teresina")
      # @see https://brasilapi.com.br/docs#tag/CPTEC
      def search_location(city_name)
        get("/cptec/v1/cidade/#{city_name}")
      end

      # Previsão do tempo nas capitais.
      #
      # @return [Array<Hash>] condição atual de cada capital
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a BrasilAPI responde 404
      # @raise [BrasilAPI::ServerError] quando a fonte do CPTEC está indisponível
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::CPTEC.capital_weather
      # @see https://brasilapi.com.br/docs#tag/CPTEC
      def capital_weather
        get("/cptec/v1/clima/capital")
      end

      # Condição meteorológica de um aeroporto.
      #
      # @param code [String] código ICAO, por exemplo +"SBGR"+
      # @return [Hash] condição do aeroporto
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando o código ICAO não existe
      # @raise [BrasilAPI::ServerError] quando a fonte do CPTEC está indisponível
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Aeroporto de Guarulhos
      #   BrasilAPI::CPTEC.airport_weather("SBGR")
      # @see https://brasilapi.com.br/docs#tag/CPTEC
      def airport_weather(code)
        get("/cptec/v1/clima/aeroporto/#{code}")
      end

      # Previsão do tempo de uma cidade do CPTEC.
      #
      # Sem +days+, a previsão é de um dia. A BrasilAPI aceita até 6 dias.
      #
      # @param city_code [String, Integer] código da cidade no CPTEC
      # @param days [Integer, nil] quantidade de dias, de 1 a 6
      # @return [Hash] previsão da cidade
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a cidade não existe
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Previsão de três dias
      #   BrasilAPI::CPTEC.city_weather(244, 3)
      # @see https://brasilapi.com.br/docs#tag/CPTEC
      def city_weather(city_code, days = nil)
        if days
          get("/cptec/v1/clima/previsao/#{city_code}/#{days}")
        else
          get("/cptec/v1/clima/previsao/#{city_code}")
        end
      end

      # Previsão meteorológica da cidade mais próxima de um ponto.
      #
      # A BrasilAPI devolve até 7 dias. A precisão garantida pela fonte é de 6 dias.
      #
      # @param latitude [Float, String] latitude em graus decimais
      # @param longitude [Float, String] longitude em graus decimais
      # @return [Hash] cidade, estado, data de atualização e a lista +clima+
      # @raise [BrasilAPI::BadRequest] quando latitude ou longitude não são numéricas
      # @raise [BrasilAPI::NotFound] quando nenhuma cidade ou previsão é encontrada
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example Centro de São Paulo
      #   BrasilAPI::CPTEC.weekly_weather_by_coordinates(-23.5505, -46.6333)
      # @see https://brasilapi.com.br/docs#tag/CPTEC
      def weekly_weather_by_coordinates(latitude, longitude)
        get("/cptec/v1/clima/previsao/semana/#{latitude}/#{longitude}")
      end

      # Previsão de ondas no litoral de uma cidade.
      #
      # Sem +days+, a previsão é de um dia. A BrasilAPI aceita até 6 dias.
      #
      # @param city_code [String, Integer] código da cidade no CPTEC
      # @param days [Integer, nil] quantidade de dias, de 1 a 6
      # @return [Hash] previsão de ondas
      # @raise [BrasilAPI::BadRequest] quando a BrasilAPI responde 400
      # @raise [BrasilAPI::NotFound] quando a cidade não tem previsão de ondas
      # @raise [BrasilAPI::ServerError] quando a BrasilAPI responde 5xx
      # @raise [BrasilAPI::Timeout] quando a requisição estoura o tempo limite
      # @raise [BrasilAPI::Error] em outras respostas de erro
      # @example
      #   BrasilAPI::CPTEC.ocean_forecast(241, 2)
      # @see https://brasilapi.com.br/docs#tag/CPTEC
      def ocean_forecast(city_code, days = nil)
        if days
          get("/cptec/v1/ondas/#{city_code}/#{days}")
        else
          get("/cptec/v1/ondas/#{city_code}")
        end
      end
    end
  end
end
