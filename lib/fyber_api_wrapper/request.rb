require "httparty"
require "addressable/uri"
require "digest/sha1"

module FyberApiWrapper
  class Request
    include HTTParty

    base_uri FyberApiWrapper::Configuration::BASE_URL

    def initialize(path, default_options)
      @path = path
      @default_options = default_options
    end

    def get(options={})
      ordered_params = order_params(@default_options.merge(options || {}))

      ordered_params[:timestamp] = Time.now.to_i

      digest = begin
        query = append_api_key(params_to_query(ordered_params))
        generate_digest(query)
      end

      ordered_params[:hashkey] = digest

      FyberApiWrapper::Response.new self.class.get(@path, params = {
        query: ordered_params
      })
    end

    private

    def order_params(params)
      Hash[
        params.delete_if {|key, _| key.to_s == "hashkey" }.sort_by {|key, _| key.to_s}
      ]
    end

    def params_to_query(params)
      uri = Addressable::URI.new
      uri.query_values = params
      uri.query
    end

    def append_api_key(query)
      query << "&#{::FyberApiWrapper.configuration.api_key}"
    end

    def generate_digest(query)
      Digest::SHA1.hexdigest(query)
    end
  end
end
