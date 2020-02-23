# frozen_string_literal: true

if Rails.env.development?
  require "rack-mini-profiler"

  # initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)

  # home = lambda { |env|
  #   [200, {'Content-Type' => 'text/html'}, ["<html><body>hello!</body></html>"]]
  # }

  # builder = Rack::Builder.new do
  #   use Rack::MiniProfiler
  #   map('/') { run home }
  # end
  # run builder
end
