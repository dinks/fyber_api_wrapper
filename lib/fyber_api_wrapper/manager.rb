require "httparty"

require_relative "request"
require_relative "response"

module FyberApiWrapper
  class Manager
    def initialize(configuration)
      @configuration = configuration
    end

    def offers(options={})
      FyberApiWrapper::Request.new("/feed/v1/offers.#{@configuration.format}", @configuration.to_options) if @configuration
    end
  end
end
