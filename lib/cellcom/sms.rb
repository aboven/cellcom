require 'forwardable'
require 'attestor'

module Cellcom
  class Sms < OpenStruct
    extend Forwardable
    include Attestor::Validations

    MessagePolicy = Attestor::Policy.new(:attributes) do
      REQUIRED_ATTRIBUTES = [:to, :m]

      def validate!
        validate_require_attributes
        validate_ttl if attributes[:ttl]
        validate_mid if attributes[:mid]
        validate_msg_hexa_encoded if attributes[:cod] == 2
      end

      private

      def validate_ttl
        unless 60 <= attributes[:ttl] && attributes[:ttl] <= 10080
          invalid "invalid ttl: Must be: 60 <= ttl <= 10080(default)"
        end
      end

      def validate_mid
        unless 1 < attributes[:mid] && attributes[:mid] < 4294967295
          invalid "invalid mid: Must be: 1 < mid < 4294967295"
        end
      end

      def validate_require_attributes
        undefined_keys = REQUIRED_ATTRIBUTES - attributes.keys
        unless undefined_keys.empty?
          invalid "invalid message: #{undefined_keys.join(', ')} needs to be defined"
        end
      end

      def validate_msg_hexa_encoded
        unless attributes[:m][/\H/]
          invalid "message needs to be hexadecimal when cod == 2"
        end
      end
    end

    def initialize(params={})
      super(default_values.merge(params))
    end

    validates { MessagePolicy.new(self.to_h) }

    def deliver(client=Cellcom.client)
      client.deliver(self.to_h)
    end

    def to_hex
      message.unpack('H*')[0]
    end

    private

    def default_values
      {
        ttl: 10080
      }
    end
  end
end
