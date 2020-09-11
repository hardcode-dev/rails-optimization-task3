require 'rails_helper'

RSpec.describe ReloadJsonService do
  let(:service) { ReloadJsonService.new(file_name: 'fixtures/example.json') }

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