require 'benchmark'

puts "Start"
time = Benchmark.realtime do
  system 'rake reload_json[fixtures/small.json]'
end
puts "Finish in #{time.round(2)}"
