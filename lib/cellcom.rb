require "cellcom/version"
require 'ostruct'

module Cellcom
  class Configuration < OpenStruct; end

  module_function

  def config
    @config ||= Configuration.new
  end

  def configure
    config.tap { |configuration| yield(configuration) }
  end
end
