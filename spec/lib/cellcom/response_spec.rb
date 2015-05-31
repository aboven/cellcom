require 'spec_helper'

describe Cellcom::Response do
  describe '.new(response)' do
    let(:code) { 200 }
    let(:response_body) { 'OK 11111111111111111111111' }
    let(:raw_response) { OpenStruct.new(code: code, body: response_body) }
    let(:response) { described_class.new(raw_response) }

    it 'sets the response' do
      expect(response.code).to eq code
      expect(response.body).to eq response_body
    end

    described_class::ERRORS.each do |resp_body, (exception, message)|
      context "#{message}" do
        let(:response_body) { resp_body }

        it "fails a #{exception} exception" do
          expect { response }.to raise_error(Cellcom::Response.const_get(exception))
        end
      end
    end
  end
end
