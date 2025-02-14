class TripsImporter
  def initialize(file = 'fixtures/small.json')
    @file = file
  end

  def self.call(...)
    new(...).call
  end

  def call
    json = JSON.parse(File.read(file))

    ActiveRecord::Base.logger = nil

    clean_database

    ActiveRecord::Base.transaction do
      city_names = Set.new
      service_names = Set.new
      buses = {}

      # первый проход - собираем "справочные" данные - города, услуги, автобусы
      # собираем в Set или хэш, так чтобы удобно было вставлять в бд
      json.each do |trip|
        city_names.add trip['from']
        city_names.add trip['to']

        service_names.merge trip['bus']['services']
        buses[trip['bus']['number']] = trip['bus']['model']
      end

      # вставляем справочное
      City.insert_all city_names.map { |name| { name: name } }
      Service.insert_all service_names.map { |name| { name: name } }
      Bus.insert_all buses.map { |number, model| {  number: number, model: model }}

      # формируем хэши, чтобы удобно получить доступ к id при втором проходе
      cities = City.all.each_with_object({}) { |city, hash| hash[city.name] = city.id }
      services = Service.all.each_with_object({}) { |service, hash| hash[service.name] = service.id }
      buses = Bus.all.each_with_object({}) { |bus, hash| hash[bus.number] = bus.id }

      # тут соберём пары автобус-услуга
      buses_services = Set.new

      # тут данные по поездкам для вставки
      trips = []

      json.each do |trip|
        from_id = cities[trip['from']]
        to_id = cities[trip['to']]
        bus_id = buses[trip['bus']['number']]

        # заполняем пары автобус-услуга
        service_ids = services.values_at(*trip['bus']['services'])
        service_ids.each do |service_id|
          buses_services.add([bus_id, service_id])
        end

        trips.push({
          from_id: from_id,
          to_id: to_id,
          bus_id: bus_id,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
          })
      end

      # вставка данных о поездках
      # пока не стала батчить, т.к. и так довольно быстро происходит
      Trip.insert_all trips

      # тоже uniqueness надо добавить
      # вот такой нелегальный insert buses_services
      # вообще чаще используем has_and_belongs_to_many , потому что часто в связке потом нужны доп. данные и таймстемпы, и свой id
      # тогда можно было бы insert использовать
      if buses_services.present?
        values = buses_services.map { |arr| "(#{arr[0]}, #{arr[1]})" }.join(", ")
        sql = "INSERT INTO buses_services (bus_id, service_id) VALUES #{values};"
        ActiveRecord::Base.connection.execute(sql)
      end
    end
  end

  private

  attr_reader :file

  def clean_database
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end
end
