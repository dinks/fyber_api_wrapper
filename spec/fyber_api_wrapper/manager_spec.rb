require "spec_helper"

describe FyberApiWrapper::Manager, :with_configuration do
  let(:manager) { FyberApiWrapper::Manager.new(FyberApiWrapper.configuration) }

  describe "#offers" do
    subject { manager.offers }

    it { should be_a(FyberApiWrapper::Request) }

    describe "#get", vcr: { match_requests_on: [:method, :uri_without_timestamp] } do
      subject { super().get(options) }

      let(:options) do
        {}
      end

      context "for a successful response" do
        let(:options) do
          {
            device_id: '2b6f0cc904d137be2e1730235f5664094b83',
            locale: :de,
            ip: '109.235.143.113',
            uid: 'player1',
            pub0: 'campaign2',
            page: 2
          }
        end

        it "is a success" do
          expect { subject }.to_not raise_error
        end

        it "will be a FyberApiWrapper::Response" do
          expect(subject).to be_a(FyberApiWrapper::Response)
        end

        it "has the correct values" do
          expect(subject.count).to eql(30)
          expect(subject.pages).to eql(5)
        end

        it "has the correct information" do
          expect(subject.information).to be_a(FyberApiWrapper::Information)

          expect(subject.information.app_name).to eql("Demo iframe for publisher - do not touch")
          expect(subject.information.appid).to eql(157)
          expect(subject.information.virtual_currency).to eql("Coins")
          expect(subject.information.country).to eql("DE")
          expect(subject.information.language).to eql("DE")
          expect(subject.information.support_url).to eql("http://api.sponsorpay.com/support?appid=157&feed=on&mobile=on&uid=player1")
        end

        it "has the correct offer values" do
          expect(subject.offers).to be_a(Array)

          expect(subject.offers.size).to eql(30)

          expect(subject.offers.first.title).to eql("Telekom Smartphone")
          expect(subject.offers.first.offer_id).to eql(503178)
          expect(subject.offers.first.teaser).to eql("Formular ausf\u00fcllen\r\nGewinnspiel freischalten\r\nRegistrierungsmail best\u00e4tigen")
          expect(subject.offers.first.required_actions).to eql("Formular ausf\u00fcllen\r\nGewinnspiel freischalten\r\nRegistrierungsmail best\u00e4tigen")
          expect(subject.offers.first.link).to eql("http://api.sponsorpay.com/27ad965403fe0c270568a8321809af8e/6fc971d3eddb3f9a/mobile/DE/157/offers/503178/preview")
          expect(subject.offers.first.payout).to eql(40943)

          expect(subject.offers.first.offer_types.size).to eql(2)
          expect(subject.offers.first.offer_types.first.offer_type_id).to eql(105)
          expect(subject.offers.first.offer_types.first.readable).to eql("Registrierung")

          expect(subject.offers.first.time_to_payout).to be_a(FyberApiWrapper::Offer::TimeToPayOut)
          expect(subject.offers.first.time_to_payout.amount).to eql(1800)
          expect(subject.offers.first.time_to_payout.readable).to eql("30 Minuten")

          expect(subject.offers.first.thumbnail).to be_a(FyberApiWrapper::Offer::Thumbnail)
          expect(subject.offers.first.thumbnail.lowres).to eql("http://cdn3.sponsorpay.com/assets/174/survey_icon_square_60.png")
          expect(subject.offers.first.thumbnail.hires).to eql("http://cdn3.sponsorpay.com/assets/174/survey_icon_square_175.png")
        end
      end

      context "for an unauthorized response" do
        let(:options) do
          {
            device_id: '2b6f0cc904d137be2e1730235f5664094b83',
            locale: :de,
            ip: '109.235.143.113',
            uid: 'player1',
            pub0: 'campaign2',
            page: 2
          }
        end

        it "raises an exception" do
          expect { subject }.to raise_error(FyberApiWrapper::UnauthorizedError)
        end
      end

      context "for an bad request" do
        let(:options) do
          {
            device_id: '2b6f0cc904d137be2e1730235f5664094b83',
            locale: :de,
            ip: '109.235.143.113',
            pub0: 'campaign2',
            page: 2
          }
        end

        it "raises an exception" do
          expect { subject }.to raise_error(FyberApiWrapper::BadRequestError)
        end
      end

      context "for a response error" do
        let(:options) do
          {
            device_id: '2b6f0cc904d137be2e1730235f5664094b83',
            locale: :de,
            ip: '109.235.143.113',
            pub0: 'campaign2',
            page: 2
          }
        end

        it "raises an exception" do
          expect { subject }.to raise_error(FyberApiWrapper::ResponseError)
        end
      end

      context "for a 404" do
        before do
          stub_request(:any, /.*/).
            to_return(status: 404)
        end

        it "raises an exception" do
          expect { subject }.to raise_error(FyberApiWrapper::ResponseError)
        end
      end
    end
  end
end
