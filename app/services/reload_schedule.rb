class ReloadSchedule
  def self.call(file_name:, gc_disabled: false)
    new.call(file_name: file_name, gc_disabled: gc_disabled)
  end

  def call(file_name:, gc_disabled:)
    GC.disable if gc_disabled

    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      clear_db
      import_from_json(json)
    end
  end

  private

  def clear_db
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def import_from_json(json)
    json.each do |trip|
      @from = City.find_or_create_by(name: trip['from'])
      @to = City.find_or_create_by(name: trip['to'])

      create_bus_with_services(trip)
      create_trip(trip)
    end
  end

  def create_bus_with_services(trip)
    services = []
    trip['bus']['services'].each do |service|
      s = Service.find_or_create_by(name: service)
      services << s
    end
    @bus = Bus.find_or_create_by(number: trip['bus']['number'])
    @bus.update(model: trip['bus']['model'], services: services)
  end

  def create_trip(trip)
    Trip.create!(
      from: @from,
      to: @to,
      bus: @bus,
      start_time: trip['start_time'],
      duration_minutes: trip['duration_minutes'],
      price_cents: trip['price_cents'],
    )
  end
end