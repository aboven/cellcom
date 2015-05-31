require 'spec_helper'

describe Cellcom do
  describe '.configure' do
    let(:credentials) do
      {
        clid: 'client id',
        gwid: 'gateway id',
        pw: 'password'
      }
    end

    subject do
      described_class.configure { |c| credentials.each { |k,v| c.send(:"#{k}=", v) } }
    end

    it 'has the config variables' do
      subject
      credentials.each { |k,v| expect(described_class.config.send(k)).to eq v }
    end

    context 'when credentials missing' do
      let(:credentials) do
        {
          clid: 'client id',
          gwid: 'gateway id',
        }
      end

      before do
        described_class.instance_variable_set("@config", nil)
      end

      it 'fails if credentials missing' do
        expect { subject }.to raise_error(Attestor::InvalidError)
      end
    end
  end
end
