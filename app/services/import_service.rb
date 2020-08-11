class ImportService
  IMPORT_LIMIT = 1000

  def initialize 
    @cities = {}
    @allowed_services = {}
    @uniq_buses = {}
    @trips = []
    @counter = 0
  end

  def call
    json = JSON.parse(File.read('fixtures/large.json'))
    DatabaseCleanupService.call

    json.each do |trip|
      from = (cities[trip['from']] ||= City.create(name: trip['from']))
      to = (cities[trip['to']] ||= City.create(name: trip['to']))

      bus_id = uniq_buses["#{trip['bus']['model']}_#{trip['bus']['number']}"] ||=
        Bus.create(number: trip['bus']['number'], model: trip['bus']['model'], services: build_services(trip['bus']['services'])).id

      @counter += 1

      @trips << [ from.id, to.id, bus_id, trip['start_time'], trip['duration_minutes'], trip['price_cents'] ]

      if @counter == IMPORT_LIMIT
        import_trips(@trips)
        @trips = []
        @counter = 0
      end
    end

    if @trips.present?
      import_trips(@trips)
      @trips = nil
    end
  end

  private

  attr_accessor :cities, :allowed_services, :uniq_buses, :trips

  def import_trips(trips)
    Trip.import(%i[from_id to_id bus_id start_time duration_minutes price_cents], trips, validate: false)
  end

  def build_services(bus_services)
    bus_services.each_with_object([]) do |service, services|
      services << (allowed_services[service] ||= Service.create(name: service))
    end
  end
end
