ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    # Configure Active Storage to use local test service
    ActiveStorage::Current.url_options = { host: "localhost:3000" }
  end

  def teardown
    Warden.test_reset!
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
end
