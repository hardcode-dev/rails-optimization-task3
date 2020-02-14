# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  City.delete_all
  Bus.delete_all
  Service.delete_all
  Trip.delete_all
  ActiveRecord::Base.connection.execute('delete from buses_services;')

  JsonLoadService.call(args.file_name)
end
