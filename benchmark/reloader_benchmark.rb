require 'benchmark'

Benchmark.bmbm do |x|
  x.report("\n== Loading data from fixtures/small.json ==") do
    system 'bin/rake reload_json[fixtures/small.json]'
  end
end
