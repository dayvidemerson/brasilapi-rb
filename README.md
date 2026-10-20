<div align="center">
<h1><img src="https://raw.githubusercontent.com/BrasilAPI/BrasilAPI/main/public/brasilapi-logo-small.png" /></h1>

</div>

Gem em Ruby, sem dependências de runtime, para consultar a [BrasilAPI](https://brasilapi.com.br).

## Funcionalidades

- [x] **Bancos**
- [x] **CEP** (v1 e v2)
- [x] **CNPJ**
- [x] **CPF**
- [x] **Corretoras da CVM** e **fundos**
- [x] **CPTEC** (cidades, clima e ondas)
- [x] **DDD** (lista, v1, v2 e por UF)
- [x] **Feriados** nacionais e estaduais
- [x] **FIPE**
- [x] **IBGE** (UFs, municípios, regiões e CNAE)
- [x] **ISBN**
- [x] **NCM**
- [x] **PIX**
- [x] **Registro.br**
- [x] **Taxas**
- [x] **Câmbio**
- [x] **Dias úteis**
- [x] **Geolocalização**
- [x] **Hospitais**
- [x] **IBPT**
- [x] **IGP-M**
- [x] **CID-10**
- [x] **Incidência solar**
- [x] **Status**
- [x] **Tickers da B3**
- [x] **TUSS**

CEP v3, previsão semanal do CPTEC por coordenadas, eleições e universidades ficam de fora enquanto a BrasilAPI não responder com sucesso nessas rotas.

## Instalação

Adicione a gem ao Gemfile da aplicação:

    $ bundle add brasilapi

Sem Bundler:

    $ gem install brasilapi

## Documentação

A referência da gem, gerada com YARD, fica em [rubydoc.info/gems/brasilapi](https://rubydoc.info/gems/brasilapi) depois da publicação.

Para navegar nela na máquina local:

    $ bundle exec yard server

O servidor sobe em [http://localhost:8808](http://localhost:8808). O Ruby 3.3 não inclui mais o Webrick, então ele entra como dependência de desenvolvimento. `bundle exec rake yard` só gera os arquivos em `doc/`.

## Configuração

O tempo limite padrão é de 10 segundos (`open_timeout` e `read_timeout`):

```ruby
BrasilAPI.configure do |config|
  config.timeout = 30
end
```

`Net::OpenTimeout` e `Net::ReadTimeout` sobem como `BrasilAPI::Timeout`. Falhas HTTP são `BrasilAPI::Error` (ou uma subclasse: `NotFound`, `BadRequest` e `ServerError`) e expõem `status`, `message`, `type` e `body`.

```ruby
begin
  BrasilAPI::Bank.find_by_code(0)
rescue BrasilAPI::NotFound => e
  e.status  # 404
  e.message
  e.type
rescue BrasilAPI::Error => e
  e.status
end
```

## Uso

```ruby
require "brasilapi"
```

### Bancos

```ruby
# lista os bancos
BrasilAPI::Bank.all

# busca um banco pelo código
BrasilAPI::Bank.find_by_code(77)
```

### CNPJ

```ruby
# busca uma empresa pelo CNPJ
BrasilAPI::Company.find_by_cnpj("60316817000103")
```

### CPF

A rota devolve só validade e região fiscal, sem nome. O CPF pode ir com ou sem pontuação.

```ruby
BrasilAPI::CPF.find("000.000.000-00")
# => {"isValid"=>false}
```

### CEP

`location: true` continua sendo o atalho da v2.

```ruby
# CEP na v1
BrasilAPI::Address.find_by_zip_code("64001100")

# CEP na v2, com coordenadas
BrasilAPI::Address.find_by_zip_code("80060000", location: true)
```

### DDD

`Address.state_and_cities_by_area_code` permanece como atalho da v1.

```ruby
# cada estado e seus DDDs
BrasilAPI::DDD.all

# v2: lista de estados e cidades (DDDs que cobrem mais de um estado)
BrasilAPI::DDD.find("11")

# v1: um estado e as cidades
BrasilAPI::DDD.find("86", version: 1)
BrasilAPI::Address.state_and_cities_by_area_code("86")

# DDDs de uma UF
BrasilAPI::DDD.by_state("SP")
```

### CVM

```ruby
# corretoras; uf só é enviado quando state é informado
BrasilAPI::CVM.all
BrasilAPI::CVM.all(state: "SP")

# busca a corretora da CVM pelo CNPJ
BrasilAPI::CVM.find_by_cnpj("74014747000135")

# fundos de investimento
BrasilAPI::CVM::Fund.all(page: 1, size: 1)
BrasilAPI::CVM::Fund.find_by_cnpj("00.000.684/0001-21")
```

### Feriados

```ruby
# feriados nacionais; uf não é enviado
BrasilAPI::Holiday.by_year(2024)

# inclui os feriados estaduais
BrasilAPI::Holiday.by_year(2024, state: "SP")
```

### IBGE

Providers aceitos em `cities_by_state`: os mesmos da BrasilAPI, por exemplo `dados-abertos-br`, `gov` e `wikipedia`.

```ruby
BrasilAPI::IBGE.states
BrasilAPI::IBGE.find_state_by_code("PI")
BrasilAPI::IBGE.find_state_by_code(53)
BrasilAPI::IBGE.cities_by_state("CE")
BrasilAPI::IBGE.cities_by_state("PI", providers: ["gov"])

BrasilAPI::IBGE.regions
BrasilAPI::IBGE.find_region_by_code(1)
BrasilAPI::IBGE.states_by_region(1)
```

### CNAE

```ruby
BrasilAPI::IBGE::CNAE.classes
BrasilAPI::IBGE::CNAE.find_class("01113")
BrasilAPI::IBGE::CNAE.find_division("01")
BrasilAPI::IBGE::CNAE.find_group("011")
```

### CPTEC

`city_weather` e `ocean_forecast` aceitam até 6 dias com precisão garantida pela BrasilAPI.

```ruby
BrasilAPI::CPTEC.all
BrasilAPI::CPTEC.search_location("São Francisco")
BrasilAPI::CPTEC.capital_weather
BrasilAPI::CPTEC.airport_weather("SBGR")
BrasilAPI::CPTEC.city_weather(4801)
BrasilAPI::CPTEC.city_weather(4801, 6)
BrasilAPI::CPTEC.ocean_forecast(4701)
BrasilAPI::CPTEC.ocean_forecast(4701, 6)
```

### FIPE

`reference_table` é opcional. Quando fica `nil`, a gem não envia `tabela_referencia`. Sem `vehicle_type`, `vehicle_brands` lista as marcas de todos os tipos.

```ruby
BrasilAPI::FIPE.vehicle_brands
BrasilAPI::FIPE.vehicle_brands("carros")
BrasilAPI::FIPE.vehicle_brands("carros", 290)
BrasilAPI::FIPE.list_vehicles("carros", 59)
BrasilAPI::FIPE.vehicle_years("carros", 59, 5585)
BrasilAPI::FIPE.vehicle_details("carros", 59, 5585, "2013-3")
BrasilAPI::FIPE.vehicle_price("005329-5")
BrasilAPI::FIPE.fipe_tables
```

### ISBN

Providers aceitos: `cbl`, `mercado-editorial`, `open-library` e `google-books`.

```ruby
BrasilAPI::ISBN.search("9788545702870")
BrasilAPI::ISBN.search("9788545702870", providers: ["open-library"])
```

### NCM

```ruby
BrasilAPI::NCM.all
BrasilAPI::NCM.search("cafe")
BrasilAPI::NCM.find_by_code("01012100")
```

### PIX

```ruby
BrasilAPI::PIX.all
```

### Registro.br

```ruby
BrasilAPI::RegistroBR.whois("google.com.br")
```

### Taxas

```ruby
BrasilAPI::Taxas.all
BrasilAPI::Taxas.find_by_name("selic")
```

### Câmbio

`quote` aceita `Date` ou `String` no formato `YYYY-MM-DD`.

```ruby
BrasilAPI::Cambio.currencies
BrasilAPI::Cambio.quote("USD", Date.new(2024, 1, 15))
```

### Dias úteis

`between` aceita `Date` ou `String`. `include_national_holidays: false` faz o dia útil incluir feriados nacionais. Sem o argumento, a BrasilAPI exclui esses feriados.

```ruby
BrasilAPI::BusinessDays.between("2024-01-01", "2024-01-10")
BrasilAPI::BusinessDays.between(Date.new(2024, 1, 1), Date.new(2024, 1, 10), include_national_holidays: false)
```

### Geolocalização

```ruby
BrasilAPI::Geolocation.reverse(-23.55, -46.63)
BrasilAPI::Geolocation.reverse(-23.55, -46.63, language: "en")
```

### Hospitais

Filtros de `all`: `vertical`, `state`, `city`, `service`, `query`, `limit`, `offset`.

`nearby` aceita `zip_code`, ou `latitude` e `longitude`, ou `city` e `state`, além de `radius`, `vertical`, `service`, `limit` e `offset`.

```ruby
BrasilAPI::Hospital.all(state: "PI", limit: 1)
BrasilAPI::Hospital.nearby(zip_code: "64001100", limit: 1)
BrasilAPI::Hospital.nearby(latitude: -5.09, longitude: -42.8, radius: 10, limit: 1)
BrasilAPI::Hospital.options
BrasilAPI::Hospital.ciatox(state: "SP")
BrasilAPI::Hospital.find_by_cnes("2726998")
BrasilAPI::Hospital.states
```

### IBPT

`exception` corresponde ao query param `ex`. Sem `code`, a chamada devolve a tabela inteira da UF.

```ruby
BrasilAPI::IBPT.version
BrasilAPI::IBPT.ncm("SP")
BrasilAPI::IBPT.ncm("SP", "01012100")
BrasilAPI::IBPT.ncm("PI", "02109100", exception: "01")
BrasilAPI::IBPT.nbs("SP", "101011000")
BrasilAPI::IBPT.lc116("SP", "0101")
```

### IGP-M

`between` aceita `Date` ou `String`.

```ruby
BrasilAPI::IGPM.all
BrasilAPI::IGPM.last(2)
BrasilAPI::IGPM.between("2024-01-01", "2024-02-01")
```

### CID-10

```ruby
BrasilAPI::CID10.all
BrasilAPI::CID10.find_by_code("A00")
```

### Incidência solar

A rota usada é `GET /solar/v1?location=...`.

```ruby
BrasilAPI::Solar.incidence("Teresina")
```

### Status

```ruby
BrasilAPI::Status.check
```

### B3

Tipos de fundo aceitos: `FII`, `SETORIAL`, `FIAGRO-FII`, `FIAGRO-FIDC`, `FIAGRO-FIP`, `FIP` e `FIA`.

```ruby
BrasilAPI::B3.stocks
BrasilAPI::B3.funds("SETORIAL")
```

### TUSS

`all` aceita `name`, `code`, `limit` e `offset`. `search` também aceita `query`, `match`, `sort`, `order` e `fields`. `autocomplete` aceita `query`, `name`, `code` e `limit`.

```ruby
BrasilAPI::TUSS.all(limit: 1)
BrasilAPI::TUSS.find_by_code("10101012")
BrasilAPI::TUSS.search(query: "consulta", limit: 1)
BrasilAPI::TUSS.autocomplete(query: "cons", limit: 2)
```

## Publicação

A publicação no RubyGems acontece quando um pull request que altera a versão entra na `main`:

1. Atualize `BrasilAPI::VERSION` em `lib/brasil_api/version.rb`.
2. Mova a seção `[Unreleased]` do `CHANGELOG.md` para essa versão, com a data.
3. Abra um pull request e faça o merge na `main`.

`.github/workflows/release.yml` roda a suíte (testes com cobertura e RuboCop), cria a tag `vX.Y.Z`, publica um GitHub Release com as notas daquela versão e envia a gem com Trusted Publishing do RubyGems (OIDC). Se a versão já tiver a tag `vX.Y.Z`, o workflow não faz nada.

Antes da primeira publicação automática, registre um trusted publisher no rubygems.org para `dayvidemerson/brasilapi-rb` e o arquivo `release.yml`, sem environment do GitHub. O gemspec mantém `rubygems_mfa_required`.

## Contribuindo

Relatos de bugs e pull requests são bem-vindos em https://github.com/dayvidemerson/brasilapi-rb. Este projeto deve ser um espaço seguro e acolhedor, e quem contribui deve seguir o [código de conduta](https://github.com/dayvidemerson/brasilapi-rb/blob/main/CODE_OF_CONDUCT.md).

## Licença

A gem é software livre sob a [licença MIT](https://opensource.org/licenses/MIT).

## Código de conduta

Quem interage nos repositórios, issues, salas e listas deste projeto deve seguir o [código de conduta](https://github.com/dayvidemerson/brasilapi-rb/blob/main/CODE_OF_CONDUCT.md).

## Autor

<div align="center">

| [<img src="https://github.com/dayvidemerson.png?size=115" width=115><br><sub>@dayvidemerson</sub>](https://github.com/dayvidemerson) |
| :-: |

</div>
