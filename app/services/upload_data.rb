# frozen_string_literal: true

class UploadData
  def self.call(file_name)
    json = JSON.parse(File.read(file_name))

    services = []
    Service::SERVICES.each do |service|
      services << { name: service }
    end
    Service.import services
    uploaded_services = Service.all.inject({}) { |acc, elem| acc.merge!(elem.name => elem.id) }
    # uploaded_services == {"Ремни безопасности"=> Service, ...}

    cities = Set.new
    buses = []
    bus_numbers = {}
    json.each do |trip|
      # handle cities
      cities << { name: trip['from'] }
      cities << { name: trip['to'] }
      # handle buses
      next if bus_numbers[trip['bus']['number']].present?
      buses << Bus.new(
        number:   trip['bus']['number'],
        model:    trip['bus']['model']
      )
      bus_numbers[trip['bus']['number']] = 1
    end
    # save to DB
    result = City.import(cities.to_a, returning: [:id, :name])
    uploaded_cities = result.results.inject({}) { |acc, elem| acc.merge!(elem[1] => elem[0]) }
    # uploaded_cities == {"Сочи"=>1, "Тула"=>2, "Самара"=>3, "Красноярск"=>4, "Волгоград"=>5, "Рыбинск"=>6, "Саратов"=>7, "Москва"=>8, "Ярославль"=>9, "Ростов"=>10}
    result = Bus.import(buses, recursive: true, returning: [:id, :number])
    uploaded_buses = result.results.inject({}) { |acc, elem| acc.merge!(elem[1] => elem[0]) }    

    trips = []
    buses_services = Set.new
    until json.empty?
      trip = json.shift

      trip['bus']['services'].each do |service|
        buses_services << { bus_id: uploaded_buses[trip['bus']['number']], service_id: uploaded_services[service] }
      end
      trips << {
        bus_id:           uploaded_buses[trip['bus']['number']],
        from_id:          uploaded_cities[trip['from']],
        to_id:            uploaded_cities[trip['to']],
        start_time:       trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents:      trip['price_cents']
      }
    end
    BusesService.import [:bus_id, :service_id], buses_services.to_a
    Trip.import trips
  end
end
