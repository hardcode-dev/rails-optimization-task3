# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|

  require 'ruby-prof'
  start_time = Time.current

  # GC.disable
  # RubyProf.measure_mode = RubyProf::WALL_TIME


  # result = RubyProf::Profile.profile do
    TripsImporter.call(args.file_name)
  # end

  # printer = RubyProf::CallStackPrinter.new(result)
  # printer.print(File.open('ruby_prof_reports/callstack.html', 'w+'))

  end_time = Time.current

  p end_time - start_time
end
