class DatabaseSeeder

  def initialize(file_name)
    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')
      cities = []
      buses = []
      all_servises = Service.services.map{|s| Service.create(name: s)}
      trips = []
      last_bus = Bus.create!(number: '000', model: Bus.models.sample)
      last_bus_id = last_bus.id
      last_bus.destroy
  
      json.each do |trip|
        from = cities.find{|c| c.name == trip['from']}
        if from.nil?
          from = City.create(name: trip['from'])
          cities << from
        end
        to = cities.find{|c| c.name == trip['to']}
        if to.nil?
          to = City.create(name: trip['to'])
          cities << to
        end
        bus = buses.find{|b| b.number == trip['bus']['number']}
        if bus.nil?
          services = all_servises.select{|s| trip['bus']['services'].include?(s.name)}
          # byebug
          bus = Bus.new(id: last_bus_id += 1, number: trip['bus']['number'], model: trip['bus']['model'], services: services)
          buses << bus
        end
  
        trips << {
          from_id: from.id,
          to_id: to.id,
          bus_id: bus.id,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        }
      end

      Bus.import buses
      BusesService.import buses.map(&:buses_services).flatten
      Trip.import trips
    end
  end

end