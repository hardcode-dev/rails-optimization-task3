require 'benchmark'

Benchmark.bmbm do |x|
  x.report("Loading data from fixtures/small.json") { system 'bin/rake reload_json[fixtures/small.json]' }
end
