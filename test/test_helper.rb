ENV['RAILS_ENV'] = 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  #
  def benchmark_with_limit(timeout = 150, &block)
    return nil unless block_given?
    actual = Benchmark.ms { @response = yield }
    assert(actual < timeout, "Response is too slow: Limit was #{timeout}, actual was #{actual}")
    @response
  end
end
