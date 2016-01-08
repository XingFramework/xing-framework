RSpec.configure do |config|
  config.before(:each) do |example|
    Rails.logger.debug "Step: #{example.description}"
  end
end
