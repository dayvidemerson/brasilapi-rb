<div align="center">
<h1><img src="https://raw.githubusercontent.com/BrasilAPI/BrasilAPI/main/public/brasilapi-logo-small.png" /></h1>

</div>

Dependency-less Brasil API lookup gem for brazilian data with an easy-to-use API.

## Features
 - [x] **Bank**
 - [x] **CEP (Zip code)**
 - [x] **CNPJ**
 - [ ] **Corretoras**
 - [ ] **CPTEC**
 - [ ] **DDD**
 - [ ] **Feriados Nacionais**
 - [ ] **FIPE**
 - [ ] **IBGE**
 - [ ] **ISBN**
 - [ ] **NCM**
 - [ ] **PIX**
 - [ ] **Registros BR**
 - [ ] **Taxas**

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add brasilapi

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install brasilapi

## Usage

```ruby
require 'brasilapi'

# get all banks
BrasilAPI::Bank.all
=> 
[{"ispb"=>"00000000", "name"=>"BCO DO BRASIL S.A.", "code"=>1, "fullName"=>"Banco do Brasil S.A."},
{"ispb"=>"00000208", "name"=>"BRB - BCO DE BRASILIA S.A.", "code"=>70, "fullName"=>"BRB - BANCO DE BRASILIA S.A."},
...]

# find bank by code
BrasilAPI::Bank.find_by_code(77)
=> {"ispb"=>"00416968", "name"=>"BANCO INTER", "code"=>77, "fullName"=>"Banco Inter S.A."}

# find company by cnpj
BrasilAPI::Company.find_by_cnpj("60316817000103")
=> 
{"uf"=>"SP",                                                        
 "cep"=>"04543907",                                                 
 "qsa"=>                                                            
  [{"pais"=>"ESTADOS UNIDOS",
  ...}

# find address by zip_code
BrasilAPI::Address.find_by_zip_code('64001100')
=> {"cep"=>"64001100", "state"=>"PI", "city"=>"Teresina", "neighborhood"=>"Centro", "street"=>"Praça Pedro II", "service"=>"correios"}

# find address with location by zip_code
BrasilAPI::Address.find_by_zip_code('80060000', location: true)
=> 
{"cep"=>"80060000",
 "state"=>"PR",
 ...
 "location"=>{"type"=>"Point", "coordinates"=>{"longitude"=>"-49.2614791", "latitude"=>"-25.427253"}}}
```

# License
[MIT](./LICENSE)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dayvidemerson/brasilapi-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dayvidemerson/brasilapi-rb/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Brasilapi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dayvidemerson/brasilapi-rb/blob/main/CODE_OF_CONDUCT.md).

# Autor
<div align="center">

| [<img src="https://github.com/dayvidemerson.png?size=115" width=115><br><sub>@dayvidemerson</sub>](https://github.com/dayvidemerson) |
| :-: |

</div>
