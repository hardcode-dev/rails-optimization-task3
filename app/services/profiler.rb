class Profiler
  attr_reader :file_path

  def initialize(file_path = 'fixtures/small.json')
    @file_path = file_path
  end

  def check_benchmark
    time = Benchmark.realtime do
      ImportJson.perform(file_path)
    end

    # GC.start(full_mark: true, immediate_sweep: true)

    puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)

    puts "Finished in #{time.round(2)}"
  end

  def profile_memory
    report = MemoryProfiler.report do
      ImportJson.perform(file_path)
    end

    report.pretty_print(scale_bytes: true, to_file: "reports/mp-#{Time.now.to_s}.txt")
  end

  def profile_cpu
    profile = StackProf.run(mode: :wall, raw: true) do
      ImportJson.perform(file_path)
    end
    File.write("reports/stackprof-#{Time.now.to_s}.json", JSON.generate(profile))
  end
end
