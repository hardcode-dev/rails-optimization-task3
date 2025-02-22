namespace :profile do
  desc 'Time'
  task time: :environment do
    require 'benchmark'

    puts(Benchmark.measure { DataLoader.load('fixtures/10M.json') })
  end

  desc 'Ruby prof'
  task rubyprof: :environment do
    report_path = Rails.root.join('profile', 'ruby_prof_reports')

    result = RubyProf::Profile.profile do
      DataLoader.load('fixtures/small.json')
    end

    printer = RubyProf::GraphHtmlPrinter.new(result)
    printer.print(File.open(Rails.root.join(report_path, 'graph.html'), 'w+'), :min_percent=>0)

    printer = RubyProf::CallStackPrinter.new(result)
    printer.print(File.open(Rails.root.join(report_path, 'callstack.html'), 'w+'))
  end

  desc 'Memory monitoring'
  task memory_monitoring: :environment do
    def memory_usage
      (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
    end

    io = File.open(Rails.root.join('profile', 'memory_usage.txt'), 'w')
    io << format("INITIAL MEMORY USAGE: %d MB\n", memory_usage)
    monitor_thread = Thread.new do
      while true
        io << format("MEMORY USAGE: %d MB\n", memory_usage)
        sleep(1)
      end
    ensure
      io << format("FINAL MEMORY USAGE: %d MB\n", memory_usage)
      io.close
    end

    DataLoader.load('fixtures/1M.json')
    monitor_thread.kill
  end

  desc 'Stackprof cli'
  task stackprof_cli: :environment do
    StackProf.run(mode: :wall, out: Rails.root.join('profile', 'stackprof_reports/stackprof.dump'), interval: 1000) do
      DataLoader.load('fixtures/small.json')
    end
  end

  desc 'Stackprof speedscope'
  task stackprof_speedscope: :environment do
    profile = StackProf.run(mode: :wall, raw: true) do
      DataLoader.load('fixtures/small.json')
    end

    File.write(Rails.root.join('profile', 'stackprof_reports/stackprof.json'), JSON.generate(profile))
  end
end
