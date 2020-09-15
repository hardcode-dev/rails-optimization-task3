# frozen_string_literal: true

# require 'benchmark'

module BenchmarkUtil
  class << self
    def realtime(name = '')
      time = Benchmark.realtime do
        # block.call
        yield
      end

      puts "#{name} Finish in #{time.round(2)}"
    end

    def memory
      `ps -o rss= -p #{Process.pid}`.to_i / 1024
    end

    def print_memory_usage
      puts "memory_usage: #{memory} MB"
    end

    def memory_usage
      memory_usage_before = memory
      yield
      memory_usage_after = memory
      mem_usage = memory_usage_after - memory_usage_before
      puts "memory_usage: #{mem_usage} MB"
    end
  end
end
