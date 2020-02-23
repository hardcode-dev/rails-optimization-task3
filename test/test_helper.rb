ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'database_cleaner/active_record'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  RSpec.configure do |config|
    config.around do |example|
      DatabaseCleaner.cleaning do
        example.run
      end
    end
  end
  # Add more helper methods to be used by all tests here...
end
