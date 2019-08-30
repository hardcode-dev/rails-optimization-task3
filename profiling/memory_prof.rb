# frozen_string_literal: true

puts 'Loading environment'
require 'memory_profiler'
require_relative '../config/environment'
require 'populate_database'

puts 'Profiling...'
report = MemoryProfiler.report do
  PopulateDatabase.call(file_path: 'fixtures/large.json')
end

puts 'Print results to file'
report.pretty_print(color_output: false, scale_bytes: true, to_file: 'profiling/memory_profiler.txt')
