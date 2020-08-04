# frozen_string_literal: true

require 'yajl/gzip'

class ImportTrips::ParseStreamJsonService
  GZIP_BYTES = "\x1F\x8B".unpack('C*').freeze

  attr_reader :io

  #TODO Такие "хранилища" лучше реализовать через Redis
  attr_accessor :cities, :allowed_services, :buses_ids

  def initialize(file_path:)
    file = File.open(file_path)
    first_bytes = file.read(2).unpack('C*')

    file.rewind

    @io =
      if first_bytes == GZIP_BYTES
        Yajl::Gzip::StreamReader.parse(file).each
      else
        Yajl::Parser.parse(file).each
      end

    @cities = {}
    @allowed_services = {}
    @buses_ids = {}
  end

  def call
    time = Benchmark.measure do
      ActiveRecord::Base.transaction do
        PgHero.reset_query_stats
        City.delete_all
        Bus.delete_all
        Service.delete_all
        Trip.delete_all
        ActiveRecord::Base.connection.execute('delete from buses_services;')

        cn = 0
        trips_command =
          "COPY trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) FROM STDIN with csv delimiter ';'"

        conn = ActiveRecord::Base.connection_pool.checkout
        raw  = conn.raw_connection

        raw.copy_data(trips_command) do
          @io.each do |json_line|
            from_id = city_id_by_name(json_line['from'])
            to_id = city_id_by_name(json_line['to'])
            bus_id = building_bus_id(json_line['bus'])

            raw.put_copy_data("#{from_id};#{to_id};#{json_line['start_time']};#{json_line['duration_minutes']};#{json_line['price_cents']};#{bus_id}\n")

            print "\r imported: #{cn += 1}"
          end
        end
      end
    end

    puts time
  end

  private

  def city_id_by_name(city_name)
    city_name = city_name.tr(' ', '')
    cities[city_name] ||= City.create!(name: city_name).id
  end

  def building_bus_id(bus_json)
    buses_ids["#{bus_json['number']}_#{bus_json['model']}"] ||=
      Bus.create(number: bus_json['number'], model: bus_json['model'], services: build_services(bus_json['services'])).id
  end

  def build_services(bus_services)
    bus_services.each_with_object([]) do |service, services|
      services << allowed_services[service] ||= Service.create!(name: service)
    end
  end
end
