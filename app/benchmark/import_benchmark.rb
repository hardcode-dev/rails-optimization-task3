require "benchmark"
require_relative '../services/json_importer.rb'

time = Benchmark.realtime do
  JsonImporter.new.call(file_name: Rails.root.join('fixtures', 'small.json'))
end

puts "finish in #{time.round(2)}"
