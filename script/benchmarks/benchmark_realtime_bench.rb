# frozen_string_literal: true

require "benchmark"

require_relative './benchmark_helper'

Benchmark.bm do |bm|
  bm.report('1_000') { work }
  bm.report('10_000') { work(Rails.root.join('fixtures', 'medium.json')) }
  # bm.report('100_000') { work(Rails.root.join('fixtures', 'large.json')) }
end
