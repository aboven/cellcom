require 'spec_helper'

describe Cellcom::Client do
  let(:credentials) do
    {
      clid: 'client id',
      gwid: 'gateway id',
      pw: 'password'
    }
  end

  let(:client) { described_class.new(credentials) }

  context 'when credential missing' do
    let(:credentials) do
      {
        clid: 'client id',
        gwid: 'gateway id',
      }
    end

    it 'fails' do
      expect { client }.to raise_error(Cellcom::Client::Error)
    end
  end

  describe '#deliver(payload)' do
    let(:message) { 'foo bar' }
    let(:payload) do
      {
        m: message,
        to: '32496233133',
        sid: '3228886991'
      }
    end

    let(:code) { 200 }
    let(:response_body) { 'OK 11111111111111111111111' }
    let(:response) { OpenStruct.new(code: code, body: response_body) }

    before do
      client.stub_chain(:request, :get).and_return(response)
    end

    subject { client.deliver(payload) }

    it 'sends the message' do
      expect(subject.status).to eq code
      expect(subject.body).to eq response_body
    end

    context 'when invalid sms' do
      let(:payload) do
        {
          to: '32496233133',
          sid: '3228886991'
        }
      end

      it 'fails exception' do
        expect { subject }.to raise_error(Cellcom::Client::Error)
      end
    end
  end
end
