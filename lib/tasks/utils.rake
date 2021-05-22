# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  time = Time.current

  ActiveRecord::Base.transaction do
    TruncateService.call
    WriteDumpService.call(args.file_name)
  end

  puts "Time: #{Time.current - time}"
end
