# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  # time = Benchmark.realtime do
  #   ReloadSchedule.call(file_name: args.file_name, gc_disabled: false)
  # end
  #
  # puts "Benchmark time #{time}"


  # RubyProf.measure_mode = RubyProf::WALL_TIME
  #
  # result = RubyProf.profile do
  #   ReloadSchedule.call(file_name: args.file_name, gc_disabled: true)
  # end
  #
  # printer = RubyProf::FlatPrinter.new(result)
  # printer.print(File.open('ruby_prof_reports/flat.txt', 'w+'))
  #
  # printer = RubyProf::CallStackPrinter.new(result)
  # printer.print(File.open('ruby_prof_reports/callstack.html', 'w+'))

  # report = MemoryProfiler.report do
  #   ReloadSchedule.call(file_name: args.file_name, gc_disabled: true)
  # end
  # report.pretty_print(scale_bytes: true)
  #
  StackProf.run(mode: :wall, out: 'stackprof_reports/stackprof.dump', raw: true) do
    ReloadSchedule.call(file_name: args.file_name, gc_disabled: true)
  end
end

