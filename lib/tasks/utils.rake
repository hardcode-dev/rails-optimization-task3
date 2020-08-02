# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.measure do
    json = JSON.parse(File.read(args.file_name))

    cities = {}
    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      json.each do |trip|
        #TODO тут мы могли бы проверять наличие ключа методом has_key? вместо present? - но тут мы хотим убедиться, что есть содерживое
        cities[trip['from']] = City.find_or_create_by(name: trip['from']) unless cities[trip['from']].present?
        cities[trip['to']] = City.find_or_create_by(name: trip['to']) unless cities[trip['to']].present?

        from = cities[trip['from']]
        to = cities[trip['to']]

        services = []
        trip['bus']['services'].each do |service|
          s = Service.find_or_create_by(name: service)
          services << s
        end
        bus = Bus.find_or_create_by(number: trip['bus']['number'])
        bus.update(model: trip['bus']['model'], services: services)

        Trip.create!(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )
      end
    end
  end

  puts time
end
