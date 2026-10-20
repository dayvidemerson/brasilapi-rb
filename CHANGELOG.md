## [Unreleased]

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
