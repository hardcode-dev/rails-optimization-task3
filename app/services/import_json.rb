class ImportJson
  def self.perform(file_path)
    json = JSON.parse(File.read(file_path))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      services_mapping = Service::SERVICES.map { |name| [name, Service.create(name: name).id] }.to_h

      buses_services_list = Set.new
      json.each do |trip|
        from = City.find_or_create_by(name: trip['from'])
        to = City.find_or_create_by(name: trip['to'])
        bus = find_or_create_bus(trip['bus'])
        trip['bus']['services'].each do |service_name|
          buses_services_list.add({
            bus_id:     bus.id,
            service_id: services_mapping[service_name]
          })
        end

        Trip.create!(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )
      end
      insert_buses_services(buses_services_list)
    end
  end

  private

  def self.insert_buses_services(buses_services_list)
    res = BusesServices.import buses_services_list.to_a
  end

  def self.find_or_create_bus(attrs)
    bus = Bus.find_or_initialize_by(number: attrs['number'])
    bus.model = attrs['model']
    bus.save if bus.will_save_change_to_model?
    bus
  end
end
