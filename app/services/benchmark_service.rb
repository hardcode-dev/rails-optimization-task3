module BenchmarkService
  class << self
    def monitoring(task_name = 'Import the schedule from json')
      puts "#{task_name}:\n" if !task_name.empty?
      mem_usage_before = print_memory
      time = Benchmark.realtime do
        yield
      end
      puts ""
      mem_usage_after = print_memory
      mem_usage = mem_usage_after - mem_usage_before
      puts "Memory usage: #{mem_usage} KB"
      puts "Finish in: #{time.round(2)}"
    end

    private

    def memory
      `ps -o rss= -p #{Process.pid}`.to_i
    end

    def print_memory
      m = memory
      puts "Memory: #{m} KB"
      m
    end
  end
end
