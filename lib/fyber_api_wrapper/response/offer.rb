module FyberApiWrapper
  class Offer
    attr_accessor :title, :offer_id, :teaser, :required_actions,
                :link, :offer_types, :payout, :time_to_payout,
                :thumbnail, :store_id

    class OfferTypes    < OpenStruct; end
    class TimeToPayOut  < OpenStruct; end
    class Thumbnail     < OpenStruct; end

    def initialize(offer_hash)
      @title            = offer_hash.fetch("title")
      @offer_id         = offer_hash.fetch("offer_id")
      @teaser           = offer_hash.fetch("teaser")
      @required_actions = offer_hash.fetch("required_actions")
      @link             = offer_hash.fetch("link")
      @payout           = offer_hash.fetch("payout")
      @store_id         = offer_hash.fetch("store_id")

      @offer_types    ||= Array(offer_hash.fetch("offer_types")).map do |offer_type|
                            FyberApiWrapper::Offer::OfferTypes.new(offer_type)
                          end

      @time_to_payout   = FyberApiWrapper::Offer::TimeToPayOut.new(offer_hash.fetch("time_to_payout"))
      @thumbnail        = FyberApiWrapper::Offer::Thumbnail.new(offer_hash.fetch("thumbnail"))
    end
  end
end
