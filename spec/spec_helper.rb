# frozen_string_literal: true

require 'rspec-benchmark'
require "rspec-sqlimit"
require 'fileutils'
require 'bundler/setup'
require 'bullet'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end
