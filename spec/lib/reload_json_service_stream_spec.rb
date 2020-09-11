require 'rails_helper'

RSpec.describe ReloadJsonServiceStream do

  context 'correct algorithm' do
    let(:service) { ReloadJsonServiceStream.new(file_name: 'fixtures/example.json') }

    it 'successfully loads example.json' do
      service.run

      expect(Trip.count).to eq(10)
      expect(Bus.count).to eq(1)
      expect(City.count).to eq(2)
      expect(BusesServicesRelation.count).to eq(2)

      expect(Trip.first.slice(:duration_minutes, :price_cents, :start_time).symbolize_keys).to(
          eq({duration_minutes: 168, price_cents: 474, start_time: '11:00'})
      )
      expect(Trip.first.from.name).to eq('Москва')
      expect(Trip.first.to.name).to eq('Самара')

      expect(Bus.first.services.pluck(:name)).to eq(%w[Туалет WiFi])

      expect(Bus.first.slice(:model, :number).symbolize_keys).to(
          eq({model: 'Икарус', number: '123'})
      )
    end
  end

  context 'fast_algorithm' do
    let(:service) { ReloadJsonServiceStream.new(file_name: 'fixtures/small.json') }

    it 'takes 1 sec' do
      time = Benchmark.realtime do
        service.run
      end

      expect(time).to be <= 0.4
    end
  end
end