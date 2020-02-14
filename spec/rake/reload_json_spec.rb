# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'reload_json', type: :rake do
  include_context 'rake'
  let(:correct_cities) { [OpenStruct.new(name: 'Москва'), OpenStruct.new(name: 'Самара')] }
  let(:correct_buses) { [OpenStruct.new(number: '123', model: 'Икарус')] }
  let(:correct_trips) do
    [
      OpenStruct.new(start_time: '11:00', duration_minutes: 168, price_cents: 474),
      OpenStruct.new(start_time: '17:30', duration_minutes: 37, price_cents: 173),
      OpenStruct.new(start_time: '12:00', duration_minutes: 323, price_cents: 672),
      OpenStruct.new(start_time: '18:30', duration_minutes: 315, price_cents: 969),
      OpenStruct.new(start_time: '13:00', duration_minutes: 304, price_cents: 641),
      OpenStruct.new(start_time: '19:30', duration_minutes: 21, price_cents: 663),
      OpenStruct.new(start_time: '14:00', duration_minutes: 598, price_cents: 629),
      OpenStruct.new(start_time: '20:30', duration_minutes: 292, price_cents: 22),
      OpenStruct.new(start_time: '15:00', duration_minutes: 127, price_cents: 795),
      OpenStruct.new(start_time: '21:30', duration_minutes: 183, price_cents: 846)
    ]
  end
  let(:correct_services) { [OpenStruct.new(name: 'Туалет'), OpenStruct.new(name: 'WiFi')] }

  context 'for cities' do
    it 'should clean previous cities' do
      City.create(name: 'wrong_name')
      subject.invoke('spec/fixtures/example.json')

      expect(City.exists?(name: 'wrong_name')).to be_falsy
    end

    context 'data import' do
      before do
        subject.invoke('spec/fixtures/example.json')
      end

      it 'should load all cities' do
        expect(City.count).to eq correct_cities.size
      end

      it 'should load cities with correct arguments' do
        correct_cities.each do |correct_city|
          expect(City.exists?(name: correct_city.name)).to be_truthy
        end
      end
    end
  end

  context 'for buses' do
    it 'should clean previous buses' do
      Bus.create(number: 'wrong_number', model: Bus::MODELS.first)
      subject.invoke('spec/fixtures/example.json')

      expect(Bus.exists?(number: 'wrong_number')).to be_falsy
    end

    context 'data import' do
      before do
        subject.invoke('spec/fixtures/example.json')
      end

      it 'should load all buses' do
        expect(Bus.count).to eq correct_buses.size
      end

      it 'should load buses with correct attributes' do
        correct_buses.each do |correct_bus|
          expect(Bus.exists?(number: correct_bus.number, model: correct_bus.model)).to be_truthy
        end
      end

      it 'should associate correct trips with buses' do
        buses = Bus.all

        buses.each do |bus|
          trips = bus.trips.map do |trip|
            OpenStruct.new(start_time: trip.start_time,
                           duration_minutes: trip.duration_minutes,
                           price_cents: trip.price_cents)
          end

          trips.each do |trip|
            expect(correct_trips).to include trip
          end
        end
      end

      it 'should associate correct services with buses' do
        buses = Bus.all

        buses.each do |bus|
          services = bus.services.map do |service|
            OpenStruct.new(name: service.name)
          end

          services.each do |service|
            expect(correct_services).to include service
          end
        end
      end
    end
  end

  context 'for services' do
    it 'should clean previous services' do
      Service.create(name: 'Ремни безопасности')
      subject.invoke('spec/fixtures/example.json')

      expect(Service.exists?(name: 'Ремни безопасности')).to be_falsy
    end

    context 'data import' do
      before do
        subject.invoke('spec/fixtures/example.json')
      end

      it 'should correctly load all services' do
        expect(Service.count).to eq correct_services.size
      end

      it 'should load services with correct attributes' do
        correct_services.each do |correct_service|
          expect(Service.exists?(name: correct_service.name)).to be_truthy
        end
      end

      it 'should associate correct buses with services' do
        services = Service.all

        services.each do |service|
          buses = service.buses.map do |bus|
            OpenStruct.new(number: bus.number, model: bus.model)
          end

          buses.each do |bus|
            expect(correct_buses).to include bus
          end
        end
      end
    end
  end

  context 'for trips' do
    it 'should clean previous trips' do
      bus = Bus.create(number: 'wrong_number', model: Bus::MODELS.first)
      city = City.create(name: 'wrong_name')
      Trip.create(from_id: city.id, to_id: city.id, start_time: '00:00', duration_minutes: 1,
                  price_cents: 1, bus_id: bus.id)
      subject.invoke('spec/fixtures/example.json')

      expect(Trip.exists?(start_time: '00:00')).to be_falsy
    end

    context 'data import' do
      before do
        subject.invoke('spec/fixtures/example.json')
      end

      it 'should correctly load all trips' do
        expect(Trip.count).to eq correct_trips.size
      end

      it 'should load trips with correct attributes' do
        correct_trips.each do |correct_trip|
          expect(Trip.exists?(start_time: correct_trip.start_time,
                              duration_minutes: correct_trip.duration_minutes,
                              price_cents: correct_trip.price_cents)).to be_truthy
        end
      end

      it 'should associate correct buses with trips' do
        trips = Trip.all

        trips.each do |trip|
          bus = OpenStruct.new(number: trip.bus.number, model: trip.bus.model)
          expect(correct_buses).to include bus
        end
      end

      it 'should associate correct cities with trips' do
        trips = Trip.all

        trips.each do |trip|
          from_city = OpenStruct.new(name: trip.from.name)
          to_city = OpenStruct.new(name: trip.to.name)
          [from_city, to_city].each do |city|
            expect(correct_cities).to include city
          end
        end
      end
    end
  end
end
