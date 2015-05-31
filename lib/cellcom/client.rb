require 'cellcom/request'
require 'cellcom/response'
require 'cellcom/sms'

module Cellcom
  class Client
    Error = Class.new(StandardError)

    attr_reader :credentials

    def initialize(params=Cellcom.config.to_h)
      Configuration::CredentialsPolicy.new(params).validate!
      @credentials = params
    rescue Attestor::InvalidError
      fail(Error)
    end

    def deliver(params)
      Sms::MessagePolicy.new(params).validate!
      Response.new request(params).get
    rescue Attestor::InvalidError
      fail Error
    end

    private

    def request(params)
      payload = upcase_keys_of_hash @credentials.merge(params)
      Request.new payload
    end

    def upcase_keys_of_hash(params)
      Hash[params.map { |k,v| [k.upcase, v] }]
    end
  end
end
