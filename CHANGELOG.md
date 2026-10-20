## [Unreleased]

## [0.9.0] - 2026-10-20

### DDD
- `BrasilAPI::DDD.all`
- `BrasilAPI::DDD.find(ddd, version: 2)`
- `BrasilAPI::DDD.by_state(state)`
- `Address.state_and_cities_by_area_code` permanece para a v1

### CPTEC
- Specs de `capital_weather` e `airport_weather`
- A previsão semanal por latitude/longitude não entrou: a rota responde 404 para coordenadas válidas

### CVM
- `CVM.all(state:)` filtra corretoras por UF e omite `uf` quando o estado não é informado
- `BrasilAPI::CVM::Fund.all(page:, size:)`
- `BrasilAPI::CVM::Fund.find_by_cnpj`, aceitando CNPJ com ou sem pontuação

### FIPE
- `vehicle_brands` sem tipo de veículo lista todas as marcas
- `vehicle_years(type, brand, model, reference_table = nil)`
- `vehicle_details(type, brand, model, year, reference_table = nil)`
- Specs das rotas que já existiam (`vehicle_price`, `fipe_tables`, `list_vehicles`)

### IBGE
- `IBGE.regions`, `IBGE.find_region_by_code` e `IBGE.states_by_region`
- `BrasilAPI::IBGE::CNAE.classes`, `find_class`, `find_division` e `find_group`

### Feriados
- `Holiday.by_year(year, state:)` inclui feriados estaduais e omite `uf` quando o estado não é informado

### Câmbio
- `BrasilAPI::Cambio.currencies`
- `BrasilAPI::Cambio.quote(currency, date)`, aceitando `Date` ou `String`

### CPF
- `BrasilAPI::CPF.find`, com ou sem pontuação

### Dias úteis
- `BrasilAPI::BusinessDays.between(start_date, end_date, include_national_holidays:)`

### Geolocalização
- `BrasilAPI::Geolocation.reverse(latitude, longitude, language: nil)`

### Hospitais
- `BrasilAPI::Hospital.all`, `nearby`, `options`, `ciatox`, `find_by_cnes` e `states`

### IBPT
- `BrasilAPI::IBPT.version`
- `IBPT.ncm(state, code = nil, exception: nil)`
- `IBPT.nbs(state, code = nil, exception: nil)`
- `IBPT.lc116(state, code = nil, exception: nil)`

### IGP-M
- `BrasilAPI::IGPM.all`, `IGPM.last(limit)` e `IGPM.between(initial_date, final_date)`

### CID-10
- `BrasilAPI::CID10.all` e `CID10.find_by_code`

### Incidência solar
- `BrasilAPI::Solar.incidence(location)` na rota real `/solar/v1`

### Status
- `BrasilAPI::Status.check`

### B3
- `BrasilAPI::B3.stocks` e `B3.funds(type)`

### TUSS
- `BrasilAPI::TUSS.all`, `find_by_code`, `search` e `autocomplete`

### ISBN, NCM, PIX, Registro.br e Taxas
- Specs com cassettes VCR para os métodos que já existiam

### Documentação e qualidade
- README com exemplo de cada endpoint, comentário da CVM corrigido e uma única seção de licença
- Documentação YARD de toda a API pública (`rake yard`); `rake yard_stats` exige 100% documentado
- `webrick` como dependência de desenvolvimento, para `bundle exec yard server` no Ruby 3.3+
- `Style/Documentation` do RuboCop volta a ser exigido
- Metadado `documentation_uri` aponta para https://rubydoc.info/gems/brasilapi
- SimpleCov passa a exigir 100% de cobertura de linha e de branch em `bundle exec rake`
- Não entram nesta versão, porque a BrasilAPI não responde com sucesso: CEP v3, previsão semanal do CPTEC por coordenadas, eleições e universidades

## [0.8.0] - 2026-10-20

- `BrasilAPI::NotFound` passa a herdar de `BrasilAPI::Error`, então `rescue BrasilAPI::Error` também captura 404
- Erros HTTP preservam status, corpo e os campos `message`/`type` da BrasilAPI; qualquer resposta 2xx é sucesso
- Novas subclasses `BadRequest` (400), `ServerError` (5xx) e `Timeout`, todas filhas de `BrasilAPI::Error`
- Timeout padrão de 10 segundos, configurável com `BrasilAPI.configure { |config| config.timeout = 30 }`
- Segmentos de URL são escapados com `URI.encode_uri_component`, sem `URI::Parser#escape` (obsoleto no Ruby 3.4+)
- FIPE deixa de enviar `tabela_referencia` vazio quando o parâmetro é nil
- CI dispara em push na `main` e em pull requests, nas Rubies suportadas 3.3, 3.4 e 4.0
- Ruby mínima sobe de 2.6 para 3.3, porque 2.6–3.2 estão fora de manutenção
- Publicação automática no RubyGems via Trusted Publishing (OIDC), sem API key
- Testes da API do CPTEC
- Metadado `github_repo` no gemspec
- Correção do texto "Dado aisso" na descrição do gemspec

## [0.7.0] - 2025-04-21

- Integração da API do CPTEC
- Integração da API da Tabela FIPE
- Integração da API de ISBN
- Integração da API de NCM
- Integração da API de PIX
- Integração da API de Registros BR
- Integração da API de Taxas

## [0.6.0] - 2024-02-25

- Integração da API do IBGE

## [0.5.1] - 2023-12-01

- Corrigindo versão publicada no RubyGems

## [0.5.0] - 2023-12-01

- Integração da API de Corretoras ativas listadas na CVM

## [0.4.0] - 2023-10-30

- Integração da API de Feriados Nacionais

## [0.3.0] - 2023-10-26

- Integração da API de dados relacionados ao DDD

## [0.2.0] - 2023-10-24

- Integração da API de CEP's

## [0.1.1] - 2023-10-23

- Corrigindo versão publicada no RubyGems

## [0.1.0] - 2023-10-23

- Configuração do Projeto
- Integração da API de Bancos
- Integração da API de CNPJ's
- Atualizar README com informações de instalação e sobre a BrasilAPI
