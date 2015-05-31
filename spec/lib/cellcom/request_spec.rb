require 'spec_helper'

describe Cellcom::Request do
  describe '#get(opts={})' do
    let(:params) do
      {
        M: 'foo',
        SID: 'bar'
      }
    end
    let(:connection) { double(:connection) }
    let(:http) { double(:http) }
    let(:request) { described_class.new(params) }

    before do
      expect(request).to receive(:connection).and_return(http)
      expect(http).to receive(:start).and_yield(connection)
    end

    after { request.get }

    it 'makes the request' do
      expect(connection).to receive(:request).with(an_instance_of(Net::HTTP::Get))
    end
  end
end
