module RunBenchmark
  def self.call
    time = Benchmark.measure do
      yield
    end
    { runtime_sec: time.real.round(2), memory_mb: (`ps -o rss= -p #{Process.pid}`.to_i / 1024) }
  end
end
