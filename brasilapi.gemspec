# frozen_string_literal: true

require_relative "lib/brasilapi/version"

Gem::Specification.new do |spec|
  spec.name = "brasilapi"
  spec.version = BrasilAPI::VERSION
  spec.authors = ["Dayvid Emerson"]
  spec.email = ["dayvidemerson96@gmail.com"]

  spec.summary = "Cliente desenvolvido em Ruby para o consumo da Brasil API que permite buscar informações públicas " \
                "referentes ao Brasil de modo eficiente e simplificado."

  spec.description = "Acesso programático de informações é algo fundamental na comunicação entre sistemas, mas, para " \
                     "nossa surpresa, uma informação tão útil e pública quanto um CEP não consegue ser acessada " \
                     "diretamente por um navegador por conta da API dos Correios não possuir CORS habilitado. Dado a" \
                     "isso, este projeto experimental tem como objetivo centralizar e disponibilizar endpoints " \
                     "modernos com baixíssima latência utilizando tecnologias como Vercel Smart CDN responsável por " \
                     "fazer o cache das informações em atualmente 23 regiões distribuídas ao longo do mundo " \
                     "(incluindo Brasil). Então não importa o quão devagar for a fonte dos dados, nós queremos " \
                     "disponibilizá-la da forma mais rápida e moderna possível."

  spec.homepage = "https://brasilapi.com.br"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/dayvidemerson/brasilapi-rb"
  spec.metadata["changelog_uri"] = "https://github.com/dayvidemerson/brasilapi-rb/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
