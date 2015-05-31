require 'spec_helper'

describe Cellcom::Sms do
    let(:message) { 'foo bar' }
    let(:ttl) { 70 }
    let(:mid) { 70 }
    let(:payload) do
      {
        m: message,
        to: '32496233133',
        sid: '3228886991',
        ttl: ttl,
        mid: mid
      }
    end

  describe '.new(params)' do
    subject { described_class.new(payload) }

    it 'sets the params' do
      payload.each { |k,v| expect(subject.send(k)).to eq v }
    end

    it 'is valid' do
      expect(subject.validate).to be_valid
    end

    context 'when invalid ttl' do
      let(:ttl) { 50 }

      it 'fails at validation' do
        expect { subject.validate! }.to raise_error(Attestor::InvalidError)
      end
    end

    context 'when invalid mid' do
      let(:mid) { 4294967296 }

      it 'fails at validation' do
        expect { subject.validate! }.to raise_error(Attestor::InvalidError)
      end
    end
  end

  describe '.deliver(client=Cellcom.client)' do
    let(:client) { double(:client) }
    let(:sms) { described_class.new(payload) }

    after { sms.deliver(client) }

    it 'sends calls deliver on the client' do
      expect(client).to receive(:deliver).with(sms.to_h)
    end
  end
end
