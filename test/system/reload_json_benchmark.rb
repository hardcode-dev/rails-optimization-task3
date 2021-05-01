# frozen_string_literal: true

require 'test_helper'

require "minitest/benchmark"

FIXTURE_FILE = 'fixtures/large.json'
EXPECTED_EXECUTION_TIME = -30

class ReloadJSONBenchmark < Minitest::Benchmark
  def bench_load_time
    validation = proc do |range, times|
      [range, times].transpose.each do |count, time|
        assert_operator time, :<, EXPECTED_EXECUTION_TIME,
                        "JSON load from #{FIXTURE_FILE} is too slow (#{time}s)"
      end
    end

    assert_performance(validation) do |n|
      require 'rake'
      Task4::Application.load_tasks
      Rake::Task['reload_json'].invoke(FIXTURE_FILE)
    end
  end

end
