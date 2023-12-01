# frozen_string_literal: true

RSpec.describe BrasilAPI::CVM do
  let(:agora_ctvm) do
    {
      "cnpj" => "74014747000135",
      "type" => "CORRETORAS",
      "nome_social" => "AGORA CTVM S.A.",
      "nome_comercial" => "AGORA-SENIOR CTVM S.A .",
      "status" => "EM FUNCIONAMENTO NORMAL",
      "email" => "ipc.supervisao.corretoras@bradesco.com.br",
      "telefone" => "21786198",
      "cep" => "1310917",
      "pais" => "",
      "uf" => "SP",
      "municipio" => "SÃO PAULO",
      "bairro" => "BELA VISTA",
      "complemento" => "3° ANDAR",
      "logradouro" => "AVENIDA PAULISTA ,1450",
      "data_patrimonio_liquido" => "2022-12-31",
      "valor_patrimonio_liquido" => "449810368.63",
      "codigo_cvm" => "2895",
      "data_inicio_situacao" => "1993-12-22",
      "data_registro" => "1993-12-22"
    }
  end

  describe ".all" do
    it "does not raise error" do
      VCR.use_cassette("cvm/all/success") do
        expect { described_class.all }.not_to raise_error
      end
    end

    it "returns an array" do
      VCR.use_cassette("cvm/all/success") do
        expect(described_class.all).to be_a(Array)
      end
    end

    it "returns 'Banco do Brasil'" do
      VCR.use_cassette("cvm/all/success") do
        expect(described_class.all).to include(agora_ctvm)
      end
    end
  end

  describe ".find_by_cnpj" do
    let(:agora_ctvm_cnpj) { "74014747000135" }
    let(:atrium_dtvm_cnpj) { "62122718000108" }
    let(:invalid_cnpj) { "35898354000180" }

    it "does not raise error" do
      VCR.use_cassette("cvm/find_by_cnpj/atrium_dtvm_cnpj") do
        expect { described_class.find_by_cnpj(atrium_dtvm_cnpj) }.not_to raise_error
      end
    end

    it "returns the agora ctvm info" do
      VCR.use_cassette("cvm/find_by_cnpj/agora_ctvm") do
        expect(described_class.find_by_cnpj(agora_ctvm_cnpj)).to eq(agora_ctvm)
      end
    end

    it "raise error not found" do
      VCR.use_cassette("cvm/find_by_cnpj/not_found") do
        expect { described_class.find_by_cnpj(invalid_cnpj) }.to raise_error(BrasilAPI::NotFound)
      end
    end
  end
end
