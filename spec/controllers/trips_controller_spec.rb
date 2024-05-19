require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  render_views

  let(:from) { City.create!(name: 'Екатеринбург') }
  let(:to) { City.create!(name: 'Белград') }
  let(:services) { Service::SERVICES.map { |service_name| Service.create!(name: service_name) } }
  let(:buses) {
    [
      Bus.create!(
        number: 1,
        model: 'Икарус',
        services: services.sample(3)
      ),
      Bus.create!(
        number: 2,
        model: 'Икарус',
        services: services.sample(3)
      ),
      Bus.create!(
        number: 3,
        model: 'Икарус',
        services: services.sample(3)
      )
    ]
  }
  let(:create_trips) {
    10.times.map do |t|
      Trip.create!(
        from:             from,
        to:               to,
        bus:              buses[t % buses.size],
        start_time:       "16:11",
        duration_minutes: '81',
        price_cents:      '12345',
      )
    end
  }

  before(:each) do
    Trip.delete_all
    City.delete_all
    Bus.delete_all
    BusesService.delete_all
    Service.delete_all
  end

  it "doesn't send unnecessary requests to db" do
    create_trips

    expect {
      get :index, params: { from: 'Екатеринбург', to: 'Белград' }
    }.not_to exceed_query_limit(6)
  end
end
