require 'rails_helper'

describe ImportJson do
  subject { described_class.new('fixtures/example.json').perform }

  describe '#perform' do
    it 'creates right amount of cities' do
      expect { subject }.to change(City, :count).by(2)
    end

    it 'saves correct city attrs' do
      subject
      expect(City.all.pluck(:name)).to match_array(%w[Москва Самара])
    end

    it 'creates right amount of buses' do
      expect { subject }.to change(Bus, :count).by(1)
    end

    it 'saves correct bus attrs' do
      subject
      bus = Bus.last
      expect(bus.number).to eq 123
      expect(bus.model).to eq 'Икарус'
      expect(bus.services.map(&:name)).to match_array %w[Туалет WiFi]
    end

    it 'creates all services' do
      subject
      expect(Service.all.pluck(:name)).to match_array Service::SERVICES
    end

    it 'creates right amount of trips' do
      expect { subject }.to change(Trip, :count).by(10)
    end

    it 'saves correct attributes to trip' do
      subject
      trip = Trip.first
      expect(trip.from.name).to eq 'Москва'
      expect(trip.to.name).to eq 'Самара'
      expect(trip.start_time).to eq '11:00'
      expect(trip.duration_minutes).to eq 168
      expect(trip.price_cents).to eq 474
      expect(trip.bus_number).to eq 123
    end


    it 'performs large data under 20 sec' do
      expect {
        described_class.new('fixtures/large.json').perform
      }.to perform_under(20).sec
    end
  end
end
