require 'spec_helper'

describe Cellcom do
  describe '.configure' do
    let(:config) do
      {
        clid: 'client id',
        gwid: 'gateway id',
        pw: 'password'
      }
    end

    before do
      described_class.configure do |c|
        config.each { |k,v| c.send(:"#{k}=", v) }
      end
    end

    subject { described_class.config }

    it 'has the config variables' do
      config.each { |k,v| expect(subject.send(k)).to eq v }
    end
  end
end
