# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
# rake 'reload_json[fixtures/small.json]'

task :reload_json, [:file_name] => :environment do |_task, args|
  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    Bus.delete_all
    Trip.delete_all

    json.each do |trip|
      services = trip['bus']['services']
      bus = Bus.find_or_create_by(number: trip['bus']['number'])
      bus.update(model: trip['bus']['model'], services: services)

      Trip.create!(
        from: trip['from'],
        to: trip['to'],
        bus: bus,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
      )
    end
  end
end
