# frozen_string_literal: true

require 'rspec-benchmark'
require 'fileutils'
require 'bundler/setup'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end
