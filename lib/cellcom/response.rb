require 'forwardable'
module Cellcom
  class Response
    extend Forwardable

    ERRORS = {
      'ERROR 10' => ['WrongCredentials', 'Wrong client id or password'],
      'ERROR 20' => ['WrongGateway', 'Wrong gateway number (GWID)'],
      'ERROR 30' => ['NotEnoughCredit', 'Not enough credit left'],
      'ERROR 40' => ['WrongDestination', 'Recipient number is wrong, or destination not covered'],
      'ERROR 50' => ['SenderIdNotSupported', 'Sender ID not supported'],
      'ERROR 60' => ['InvalidMessage', 'Message is too long or invalid'],
      'ERROR 70' => ['Timeout', 'Timeout, please retry later'],
      'ERROR 80' => ['InternalError', 'Internal error, please contact Cellcom']
    }.freeze

    ERRORS.each do |key,(class_name, _)|
      const_set(class_name, Class.new(StandardError))
    end

    attr_reader :raw_response
    def_delegators :@raw_response, :code, :body

    alias_method :status, :code

    def initialize(raw_response)
      @raw_response = raw_response
      raise_error(raw_response.body) if ERRORS.keys.include?(raw_response.body)
    end

    def raise_error(error_key)
      error_val = ERRORS.fetch(error_key)
      fail Response.const_get(error_val[0]), error_val[1]
    end
  end
end
