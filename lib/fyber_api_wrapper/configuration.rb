module FyberApiWrapper
  class Configuration
    attr_accessor :appid, :offer_types, :api_key, :format

    BASE_URL = 'api.sponsorpay.com'

    def to_options
      {
        appid: appid,
        offer_types: Array(offer_types).join(',')
      }.reject {|_, value| value.nil? }
    end
  end
end
