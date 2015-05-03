require "httparty"
require "ostruct"

require_relative "response/information"
require_relative "response/offer"
require_relative "response/errors"

module FyberApiWrapper
  class Response
    def initialize(response)
      @response = response

      raise_if_unauthorized!
      raise_if_bad_request!
      raise_if_response_error!

      @parsed_response = response.parsed_response
    end

    def pages
      @parsed_response.fetch("pages")
    end

    def count
      @parsed_response.fetch("count")
    end

    def information
      @information ||= FyberApiWrapper::Information.new(@parsed_response.fetch("information"))
    end

    def offers
      @offers ||= Array(@parsed_response.fetch("offers")).map do |offer|
                    FyberApiWrapper::Offer.new(offer)
                  end
    end

    private

    def raise_if_unauthorized!
      raise FyberApiWrapper::UnauthorizedError.new if @response.code == 401
    end

    def raise_if_bad_request!
      raise FyberApiWrapper::BadRequestError.new if @response.code == 400
    end

    def raise_if_response_error!
      raise FyberApiWrapper::ResponseError.new if @response.code != 200
    end
  end
end
