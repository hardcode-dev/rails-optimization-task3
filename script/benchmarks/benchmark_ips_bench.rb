require 'benchmark/ips'

require_relative './benchmark_helper'

suite = GCSuite.new
Benchmark.ips do |bm|
  bm.config(
    suite: suite,
    stats: :bootstrap,
    confidence: 95
  )

  bm.report('1000') { work }
end
