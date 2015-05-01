require "spec_helper"

describe FyberApiWrapper do
  subject { FyberApiWrapper::VERSION }

  it { should eql("0.0.1") }
end
