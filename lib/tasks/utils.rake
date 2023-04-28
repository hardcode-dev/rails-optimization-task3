# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name, :profiler] => :environment do |_task, args|
  case args.profiler
  when 'memory'
    report = MemoryProfiler.report do
      ImportData.run!(file_name: args.file_name)
    end

    report.pretty_print(scale_bytes: true, color_output: true)
    report.pretty_print(scale_bytes: true, to_file: 'reports/tmp/memory_profiler.txt')
  else
    ImportData.run!(file_name: args.file_name)
  end
end
