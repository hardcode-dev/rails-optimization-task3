require 'benchmark'

puts "Start"
time = Benchmark.realtime do
  system 'rake reload_json[fixtures/medium.json]'
end
puts "Finish in #{time.round(2)}"
