require 'ostruct'
require 'attestor'
require 'cellcom/version'
require 'cellcom/client'

module Cellcom
  class Configuration < OpenStruct
    include Attestor::Validations

    CredentialsPolicy = Attestor::Policy.new(:credentials) do
      REQUIRED_CREDENTIALS = [:pw, :clid, :gwid ]

      def validate!
        defined_keys = REQUIRED_CREDENTIALS & credentials.keys
        unless REQUIRED_CREDENTIALS == defined_keys
          invalid "#{(REQUIRED_CREDENTIALS-defined_keys).join(', ')} needs to be defined"
        end
      end
    end

    validates {CredentialsPolicy.new(self.to_h) }

    def initialize(h={})
      super default_attributes.merge(h)
    end

    private

    def default_attributes
      {
        sid: '3228000000'
      }
    end
  end

  module_function

  def client(params=config.to_h)
    Client.new(params)
  end

  def config
    @config ||= Configuration.new
  end

  def configure
    config.tap { |configuration| yield(configuration) }
    config.validate!
  end
end
