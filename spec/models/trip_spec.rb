require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:service) { FactoryBot.create(:service) }
  let(:bus) { FactoryBot.create(:bus, services: [service]) }
  let(:from_city) { FactoryBot.create(:city) }
  let(:to_city) { FactoryBot.create(:city) }
  let(:trip) { FactoryBot.create(:trip, from_id: from_city.id, to_id: to_city.id, bus_id: bus.id) }

  describe '#to_h' do
    it 'Сериализованный маршрут' do
      expect(trip.to_h).to eq({
        from: from_city.name,
        to: to_city.name,
        start_time: trip.start_time,
        duration_minutes: trip.duration_minutes,
        price_cents: trip.price_cents,
        bus: {
          number: bus.number,
          model: bus.model,
          services: bus.services.map(&:name),
        }
      })
    end
  end
end
