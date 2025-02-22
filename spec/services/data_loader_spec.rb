require 'rails_helper'

RSpec.describe DataLoader do
  subject(:load) { described_class.load('fixtures/example.json') }

  before { load }

  it 'creates buses' do
    expect(Bus.all).to contain_exactly(have_attributes(number: '123', model: 'Икарус'))
  end

  it 'creates cities' do
    expect(City.all).to contain_exactly(
      have_attributes(name: 'Москва'),
      have_attributes(name: 'Самара')
    )
  end

  it 'creates services' do
    expect(Service.all).to contain_exactly(
      have_attributes(name: 'WiFi'),
      have_attributes(name: 'Туалет')
    )
  end

  it 'creates buses_services' do
    bus = Bus.find_by(number: '123')
    wifi = Service.find_by(name: 'WiFi')
    toilet = Service.find_by(name: 'Туалет')

    expect(BusesService.all).to contain_exactly(
      have_attributes(bus_id: bus.id, service_id: wifi.id),
      have_attributes(bus_id: bus.id, service_id: toilet.id)
    )
  end

  it 'creates trips' do
    samara = City.find_by(name: 'Самара')
    moscow = City.find_by(name: 'Москва')
    bus = Bus.find_by(number: '123')

    expect(Trip.all).to contain_exactly(
      have_attributes(start_time: '11:00', duration_minutes: 168, price_cents: 474, from_id: moscow.id, to_id: samara.id, bus_id: bus.id),
      have_attributes(start_time: '17:30', duration_minutes: 37, price_cents: 173, from_id: samara.id, to_id: moscow.id, bus_id: bus.id),
      have_attributes(start_time: '12:00', duration_minutes: 323, price_cents: 672, from_id: moscow.id, to_id: samara.id, bus_id: bus.id),
      have_attributes(start_time: '18:30', duration_minutes: 315, price_cents: 969, from_id: samara.id, to_id: moscow.id, bus_id: bus.id),
      have_attributes(start_time: '13:00', duration_minutes: 304, price_cents: 641, from_id: moscow.id, to_id: samara.id, bus_id: bus.id),
      have_attributes(start_time: '19:30', duration_minutes: 21, price_cents: 663, from_id: samara.id, to_id: moscow.id, bus_id: bus.id),
      have_attributes(start_time: '14:00', duration_minutes: 598, price_cents: 629, from_id: moscow.id, to_id: samara.id, bus_id: bus.id),
      have_attributes(start_time: '20:30', duration_minutes: 292, price_cents: 22, from_id: samara.id, to_id: moscow.id, bus_id: bus.id),
      have_attributes(start_time: '15:00', duration_minutes: 127, price_cents: 795, from_id: moscow.id, to_id: samara.id, bus_id: bus.id),
      have_attributes(start_time: '21:30', duration_minutes: 183, price_cents: 846, from_id: samara.id, to_id: moscow.id, bus_id: bus.id)
    )
  end

  it 'performs example under 0.05s' do
    expect { load }.to perform_under(50).ms.warmup(2).times.sample(5).times
  end
end
