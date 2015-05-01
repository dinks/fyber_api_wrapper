require 'fyber_api_wrapper'
require 'vcr'
require 'faker'
require 'webmock/rspec'

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # config.order = :random

  Kernel.srand config.seed
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures"
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.register_request_matcher :uri_without_timestamp, &VCR.request_matchers.uri_without_params(:timestamp, :hashkey)
end
