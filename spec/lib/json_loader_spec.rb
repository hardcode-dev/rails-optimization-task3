require 'json_loader'
require 'rails_helper'

RSpec.describe JsonLoader do
  describe '#perform' do
    let(:filename) { 'fixtures/example.json' }
    subject { described_class.new.perform(filename) }

    it 'loads data from file to database' do
      subject

      # City
      cities = City.order(:name).to_a
      expect(cities.size).to eq(2) 
      city1 = cities[0]
      city2 = cities[1]

      expect(city1.name).to eq('Москва')
      expect(city2.name).to eq('Самара')

      # Bus
      buses = Bus.all.to_a
      expect(buses.size).to eq(1)
      bus = buses[0]
      expect(bus.number).to eq('123')
      expect(bus.model).to eq('Икарус')

      # Service
      services = Service.pluck(:name)
      expect(services).to include('WiFi', 'Туалет')

      # Bus Services
      expect(bus.services).to include(Service.find_by(name: 'WiFi'), Service.find_by(name: 'Туалет'))

      # Trip
      trips = Trip.order(:start_time).to_a
      expect(trips.size).to eq(10)

      trip = trips[0]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city1.id)
      expect(trip.to_id).to eq(city2.id)
      expect(trip.start_time).to eq('11:00')
      expect(trip.duration_minutes).to eq(168)
      expect(trip.price_cents).to eq(474)

      trip = trips[1]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city1.id)
      expect(trip.to_id).to eq(city2.id)
      expect(trip.start_time).to eq('12:00')
      expect(trip.duration_minutes).to eq(323)
      expect(trip.price_cents).to eq(672)

      trip = trips[2]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city1.id)
      expect(trip.to_id).to eq(city2.id)
      expect(trip.start_time).to eq('13:00')
      expect(trip.duration_minutes).to eq(304)
      expect(trip.price_cents).to eq(641)

      trip = trips[3]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city1.id)
      expect(trip.to_id).to eq(city2.id)
      expect(trip.start_time).to eq('14:00')
      expect(trip.duration_minutes).to eq(598)
      expect(trip.price_cents).to eq(629)

      trip = trips[4]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city1.id)
      expect(trip.to_id).to eq(city2.id)
      expect(trip.start_time).to eq('15:00')
      expect(trip.duration_minutes).to eq(127)
      expect(trip.price_cents).to eq(795)

      trip = trips[5]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city2.id)
      expect(trip.to_id).to eq(city1.id)
      expect(trip.start_time).to eq('17:30')
      expect(trip.duration_minutes).to eq(37)
      expect(trip.price_cents).to eq(173)

      trip = trips[6]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city2.id)
      expect(trip.to_id).to eq(city1.id)
      expect(trip.start_time).to eq('18:30')
      expect(trip.duration_minutes).to eq(315)
      expect(trip.price_cents).to eq(969)

      trip = trips[7]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city2.id)
      expect(trip.to_id).to eq(city1.id)
      expect(trip.start_time).to eq('19:30')
      expect(trip.duration_minutes).to eq(21)
      expect(trip.price_cents).to eq(663)

      trip = trips[8]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city2.id)
      expect(trip.to_id).to eq(city1.id)
      expect(trip.start_time).to eq('20:30')
      expect(trip.duration_minutes).to eq(292)
      expect(trip.price_cents).to eq(22)

      trip = trips[9]
      expect(trip.bus_id).to eq(bus.id)
      expect(trip.from_id).to eq(city2.id)
      expect(trip.to_id).to eq(city1.id)
      expect(trip.start_time).to eq('21:30')
      expect(trip.duration_minutes).to eq(183)
      expect(trip.price_cents).to eq(846)
    end
  end
end
