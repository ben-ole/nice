# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../nizzaTestApp/config/environment.rb",  __FILE__)
require "rails/test_help"
require "webrat"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# load test applications
Dir[File.expand_path('../nizzaTestApp/*.rb', __FILE__)].each do |f|
  require f
end

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end


Webrat.configure do |config|
  config.mode = :rails
end