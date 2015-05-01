require "spec_helper"

describe FyberApiWrapper do
  subject { FyberApiWrapper }

  it "exists" do
    expect(subject).to_not be_nil
  end

  it "has the configuration as nil" do
    expect(subject.configuration).to be_nil
  end

  it "has the offers as nil" do
    expect(subject.offers).to be_nil
  end

  context "set up", :with_configuration do
    it "does not have the configuration as nil" do
      expect(subject.configuration).to_not be_nil
    end

    it "does not have the offers as nil" do
      expect(subject.offers).to_not be_nil
    end
  end
end
