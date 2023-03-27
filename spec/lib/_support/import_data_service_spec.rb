require 'rails_helper'
require 'tasks/_support/import_data_service'

describe ImportDataService do
  subject(:service_call) { described_class.new(file_name).call }

  let(:file_name) { file_fixture('example.json') }

  let(:created_cities) { City.all }
  let(:created_buses) { Bus.all }
  let(:created_services) { Service.all }
  let(:created_trips) { Trip.all.as_json }
  let(:created_buses_services) { BusesService.all.as_json }

  let(:city_1) { created_cities[0] }
  let(:city_2) { created_cities[1] }
  let(:bus) { created_buses[0] }
  let(:service_1) { created_services[0] }
  let(:service_2) { created_services[1] }

  it 'imports data' do
    expect { service_call }
      .to change { [City.count, Bus.count, Service.count, Trip.count, BusesService.count] }
      .from([0, 0, 0, 0, 0])
      .to([2, 1, 2, 10, 2])

      expect(created_cities.as_json)
        .to match_array([{ 'id' => be_a(Integer), 'name' => 'Москва' }, { 'id' => be_a(Integer), 'name' =>  'Самара' }])
      expect(created_buses.as_json)
        .to match_array([{ 'id' => be_a(Integer), 'model' => 'Икарус', 'number' => '123' }])
      expect(created_services.as_json)
        .to match_array([{ 'id' => be_a(Integer), 'name' => 'Туалет' }, { 'id' => be_a(Integer), 'name' => 'WiFi' }])
      expect(created_trips).to match_array([{
        'id' => be_a(Integer),
        'from_id' => city_1.id,
        'to_id' => city_2.id,
        'start_time' => '11:00',
        'duration_minutes' => 168,
        'price_cents' => 474,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_2.id,
        'to_id' => city_1.id,
        'start_time' => '17:30',
        'duration_minutes' => 37,
        'price_cents' => 173,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_1.id,
        'to_id' => city_2.id,
        'start_time' => '12:00',
        'duration_minutes' => 323,
        'price_cents' => 672,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_2.id,
        'to_id' => city_1.id,
        'start_time' => '18:30',
        'duration_minutes' => 315,
        'price_cents' => 969,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_1.id,
        'to_id' => city_2.id,
        'start_time' => '13:00',
        'duration_minutes' => 304,
        'price_cents' => 641,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_2.id,
        'to_id' => city_1.id,
        'start_time' => '19:30',
        'duration_minutes' => 21,
        'price_cents' => 663,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_1.id,
        'to_id' => city_2.id,
        'start_time' => '14:00',
        'duration_minutes' => 598,
        'price_cents' => 629,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_2.id,
        'to_id' => city_1.id,
        'start_time' => '20:30',
        'duration_minutes' => 292,
        'price_cents' => 22,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_1.id,
        'to_id' => city_2.id,
        'start_time' => '15:00',
        'duration_minutes' => 127,
        'price_cents' => 795,
        'bus_id' => bus.id
      }, {
        'id' => be_a(Integer),
        'from_id' => city_2.id,
        'to_id' => city_1.id,
        'start_time' => '21:30',
        'duration_minutes' => 183,
        'price_cents' => 846,
        'bus_id' => bus.id
      }])
      expect(created_buses_services.as_json)
        .to match_array([
          { 'id' => be_a(Integer), 'bus_id' => bus.id, 'service_id' => service_1.id },
          { 'id' => be_a(Integer), 'bus_id' => bus.id, 'service_id' => service_2.id }
        ])
  end
end
