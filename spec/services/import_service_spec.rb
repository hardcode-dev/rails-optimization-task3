require 'rails_helper'

RSpec.describe ImportService do
  describe '#process' do
    it 'correct import data' do
      described_class.new('fixtures/example.json').process
      last_bus = Bus.last
      expect(last_bus).to have_attributes(number: '123', model: 'Икарус')
      expect(City.pluck(:name).sort).to eq(%w[Москва Самара])
      expect(
        Trip
          .joins(:from, :to)
          .where(cities: { name: 'Москва' }, tos_trips: { name: 'Самара' })
          .pluck(:start_time, :duration_minutes, :price_cents, :bus_id)
      ).to match_array([
        ['11:00', 168, 474, last_bus.id],
        ['12:00', 323, 672, last_bus.id],
        ['13:00', 304, 641, last_bus.id],
        ['14:00', 598, 629, last_bus.id],
        ['15:00', 127, 795, last_bus.id]
      ])
      expect(
        Trip
          .joins(:from, :to)
          .where(cities: { name: 'Самара' }, tos_trips: { name: 'Москва' })
          .pluck(:start_time, :duration_minutes, :price_cents, :bus_id)
      ).to match_array([
        ['17:30', 37, 173, last_bus.id],
        ['18:30', 315, 969, last_bus.id],
        ['19:30', 21, 663, last_bus.id],
        ['20:30', 292, 22, last_bus.id],
        ['21:30', 183, 846, last_bus.id]
      ])
    end

    it 'import for correct time' do
      realtime = Benchmark.realtime do
        described_class.new('fixtures/example.json').process
      end
      expect(realtime).to be < 0.1
    end
  end
end
