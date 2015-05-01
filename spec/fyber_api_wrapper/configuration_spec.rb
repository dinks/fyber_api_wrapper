require "spec_helper"

describe FyberApiWrapper::Configuration do
  it "has the BASE_URL" do
    expect(FyberApiWrapper::Configuration::BASE_URL).to eql('api.sponsorpay.com')
  end

  context "on instantiation" do
    let(:config)      { FyberApiWrapper::Configuration.new }

    let(:appid)       { Faker::Number.number(5) }
    let(:offer_types) { [ Faker::Number.number(3) ] }
    let(:api_key)     { Faker::Internet.password }
    let(:format)      { :json }

    before do
      config.appid       = appid
      config.offer_types = offer_types
      config.api_key     = api_key
      config.format      = format
    end

    describe "#to_options" do
      subject { config.to_options }

      it "has the correct hash" do
        expect(subject).to eql( appid: appid,
                                offer_types: offer_types.join(',')
                              )
      end
    end
  end
end
