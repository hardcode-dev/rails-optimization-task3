# frozen_string_literal: true

# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    json = Oj.load(File.read(args.file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Trip.delete_all
      Bus.delete_all
      Service.delete_all
      Staffing.delete_all

      trips = []
      cities = []
      services = []
      buses = []
      staffings = []

      json.each do |trip|
        from = trip['from']
        cities << from
        to = trip['to']
        cities << to

        services << trip['bus']['services']

        bus = {
          number: trip['bus']['number'],
          model: trip['bus']['model']
        }
        buses << bus

        trip['bus']['services'].each do |s|
          st = {
            bus_id: bus[:number],
            service_id: s
          }
          staffings << st
        end

        trips << {
          from_id: from,
          to_id: to,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
          bus_id: trip['bus']['number']
        }
      end
      columns = [:name]

      values = cities.uniq.permutation(1).to_a
      City.import columns, values

      values = services.flatten.uniq.permutation(1).to_a
      Service.import columns, values

      Bus.import buses.uniq
      Staffing.import staffings.uniq
      Trip.import trips
    end
  end

  puts "Finish in #{time.round(5)}"
end
