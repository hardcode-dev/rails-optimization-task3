namespace :profile do
  def target_task
    Operations::Import.new.work('fixtures/large.json')
  end

  task by_memory: :environment do
    report = MemoryProfiler.report do
      target_task
    end

    report.pretty_print(scale_bytes: true)
  end

  task by_wall_time: :environment do
    GC.disable
    RubyProf.measure_mode = RubyProf::WALL_TIME

    result = RubyProf.profile { target_task }

    printer = RubyProf::FlatPrinter.new(result)
    printer.print(File.open('log/ruby_prof_reports/flat.txt', 'w+'))

    printer = RubyProf::GraphHtmlPrinter.new(result)
    printer.print(File.open('log/ruby_prof_reports/graph.html', 'w+'))

    # printer = RubyProf::CallStackPrinter.new(result)
    # printer.print(File.open('log/ruby_prof_reports/callstack.html', 'w+'))

    GC.enable
  end

  task benchmark: :environment do
    time = Benchmark.realtime { target_task }
    puts time.round(2)
    puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)

    puts Bus.count
    puts City.count
    puts Service.count
    puts Trip.count
    puts Service.last.buses.count
  end
end