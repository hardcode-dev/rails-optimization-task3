ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'rspec-benchmark'
require 'rake'

module TaskFormat
  extend ActiveSupport::Concern
  included do
    let(:task_name) { self.class.top_level_description.sub(/\Arake /, '') }
    let(:tasks) { Rake::Task }
    # Make the Rake task available as `task` in your examples:
    subject(:task) { tasks[task_name] }
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    Dir.glob('lib/tasks/*.rake').each { |r| Rake::DefaultLoader.new.load r }
  end

  # Tag Rake specs with `:task` metadata or put them in the spec/tasks dir
  config.define_derived_metadata(file_path: %r{/spec/tasks/}) do |metadata|
    metadata[:type] = :task
  end

  config.include TaskFormat, type: :task

  config.include RSpec::Benchmark::Matchers
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
