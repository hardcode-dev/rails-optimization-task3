class LoadScheduleService
  attr_reader :file_name
  def initialize(file_name)
    @file_name = file_name
  end

  def clear_db
    puts("Deleting old data ")
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    %i[buses buses_services cities services trips].each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end

  def call(clear = true, size = 0)
    json = JSON.parse(File.read(file_name))
    pb = ProgressBar.new(size) if size

    ActiveRecord::Base.transaction do
      clear_db if clear

      puts("Наивная загрузка данных из json-файла в БД")
      json.each do |trip|
        from = City.find_or_create_by(name: trip['from'])
        to = City.find_or_create_by(name: trip['to'])
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
        pb.increment! if size
      end
    end
  end
end