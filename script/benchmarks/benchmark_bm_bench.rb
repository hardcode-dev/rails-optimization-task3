# frozen_string_literal: true

require "benchmark"

require_relative './benchmark_helper'
require_relative '../../lib/json_importer'

with_rss do
  seconds = Benchmark.realtime { work }

  puts "JSONImporter#call took #{seconds.truncate(2)} seconds."
end
