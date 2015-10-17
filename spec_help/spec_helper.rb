require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
SimpleCov.start

require 'rspec'
require 'rspec/core/formatters/base_formatter'
require 'cadre/rspec3'

ENV["RAILS_ENV"] ||= 'test'


ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec_help/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.add_formatter(Cadre::RSpec3::NotifyOnCompleteFormatter)
  config.add_formatter(Cadre::RSpec3::QuickfixFormatter)

  config.around(:type => :deprecation) do |example|
    ActiveSupport::Deprecation.silence(&example)
  end
end
