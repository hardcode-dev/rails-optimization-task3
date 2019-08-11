ENV['RAILS_ENV'] ||= 'test'
require 'rake'
require 'rspec-benchmark'
require_relative '../config/environment'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(rake: true) do
    Rake.application.rake_require "tasks/utils"
    Rake::Task.define_task(:environment)
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
