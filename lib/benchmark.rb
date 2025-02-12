#!/usr/bin/env ruby

# frozen_string_literal: true

require 'benchmark'

path = ARGV[0]

time = Benchmark.realtime do
  system "bin/rake utils:reload_json[fixtures/#{path}.json]"
end

def printer(time)
  puts "Processing time from file: #{time.round(4)}" 
end

printer(time)
