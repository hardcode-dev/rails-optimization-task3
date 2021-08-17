require 'benchmark'

Benchmark.bmbm do |x|
  x.report("\n== Loading data from fixtures/small.json ==") do
    system 'bin/rake reload_json[fixtures/small.json]'
  end

  x.report("\n== Loading data from fixtures/medium.json ==") do
    system 'bin/rake reload_json[fixtures/medium.json]'
  end

  x.report("\n== Loading data from fixtures/large.json ==") do
    system 'bin/rake reload_json[fixtures/large.json]'
  end
end
