require 'rails_helper'

describe TripsController do
  let(:bus_1) { Bus.create(model: 'ГАЗ', number: '426', services: [service_1]) }
  let(:bus_2) { Bus.create(model: 'ГАЗ', number: '624', services: [service_1, service_2]) }

  let(:service_1) { Service.create(name: 'WiFi') }
  let(:service_2) { Service.create(name: 'Туалет') }

  let(:from_city) { City.create(name: 'Самара') }
  let(:to_city) { City.create(name: 'Москва') }

  let!(:trip_1) do
    Trip.create(
      bus: bus_1,
      from: from_city,
      to: to_city,
      duration_minutes: 168,
      price_cents: 474,
      start_time: '11:00'
    )
  end

  let!(:trip_2) do
    Trip.create(
      bus: bus_2,
      from: from_city,
      to: to_city,
      duration_minutes: 37,
      price_cents: 173,
      start_time: '17:30'
    )
  end

  it 'renders trips' do
    get Rails.application.routes.url_helpers.trips_path(from_city.name, to_city.name)

    expect(response).to have_http_status(:ok)
    expect(response.body).to match_snapshot('trips')
  end
end
