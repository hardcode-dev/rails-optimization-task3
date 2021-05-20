require 'benchmark'

Benchmark.bmbm do |x|
  # x.report("Loading data from fixtures/small.json") { system 'bin/rake reload_json[fixtures/small.json]' }
  # x.report("Loading data from fixtures/medium.json") { system 'bin/rake reload_json[fixtures/medium.json]' }
  x.report("Loading data from fixtures/large.json") { system 'bin/rake reload_json[fixtures/large.json]' }
end

puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
