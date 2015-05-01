require "fyber_api_wrapper/version"
require "fyber_api_wrapper/configuration"
require "fyber_api_wrapper/manager"

module FyberApiWrapper

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= FyberApiWrapper::Configuration.new
    yield self.configuration
  end

  def self.offers(options={})
    FyberApiWrapper::Manager.new(self.configuration).offers(options)
  end

end
