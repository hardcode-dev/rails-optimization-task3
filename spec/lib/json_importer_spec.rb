require 'rails_helper'

describe JsonImporter do

  context do
    it 'works correctly' do
      expect { JsonImporter.perform('fixtures/example.json') }
        .to change { City.count }.by(2)
        .and change { City.count }.by(2)
        .and change { Service.count }.by(2)
        .and change { Trip.count }.by(10)

      validate_trip(Trip.first, 'Москва', 'Самара', 'Икарус', %w[Туалет WiFi])
      validate_trip(Trip.last, 'Самара', 'Москва', 'Икарус', %w[Туалет WiFi])
    end
  end

  context 'performance' do
    it 'works under 10ms' do
      expect { JsonImporter.perform('fixtures/example.json') }.to perform_under(0.01).sec
    end
  end

  private

  def validate_trip(trip, from, to, model, services)
    expect(trip.from.name).to eq from
    expect(trip.to.name).to eq to
    expect(trip.bus.model).to eq model
    expect(trip.bus.services.pluck(:name)).to eq services
  end

end
