require 'yaml'

configuration = YAML.load_file('./spec/fixtures/config.yml')

RSpec.configure do |c|
  c.before(:each, :with_configuration) do
    FyberApiWrapper.configure do |config|
      config.format = configuration[:format]
      config.appid = configuration[:appid]
      config.offer_types = configuration[:offer_types]
      config.api_key = configuration[:api_key]
    end
  end

  c.after(:each, :with_configuration) do
    FyberApiWrapper.configuration = nil
  end
end
