ENV[ 'RAILS_ENV' ] = 'test'
ENV[ 'RACK_ENV' ] = 'test'

# Gems
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'webmock/rspec'


ActiveRecord::Migration.maintain_test_schema!

WebMock.disable_net_connect!( allow_localhost:true )

Capybara.javascript_driver = :selenium

Capybara.default_max_wait_time = 3

Capybara.run_server = true

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new app,
    follow_redirects:false
end

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL

  config.color = true
  config.filter_run_including focus: true
  config.run_all_when_everything_filtered = true
  config.infer_spec_type_from_file_location!
  # config.formatter = :documentation

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /bin\//,
    /gems/,
    /spec\/spec_helper\.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/
  ]

  config.before(:each) do
    DatabaseCleaner.clean
  end
end

def app
  Capybara.app
end
