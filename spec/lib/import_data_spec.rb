# frozen_string_literal: true

require 'rails_helper'
Rails.application.load_tasks

RSpec.describe 'reload_json task' do
  let(:import_data) { Rake::Task['reload_json'].invoke('fixtures/example.json') }
  let(:buses) { [{ 'id' => 1, 'number' => '123', 'model' => 'Икарус' }] }
  let(:buses_services) { [{ 'id' => 1, 'bus_id' => 1, 'service_id' => 1 }, { 'id' => 2, 'bus_id' => 1, 'service_id' => 2 }] }
  let(:cities) { [{ 'id' => 1, 'name' => 'Москва' }, { 'id' => 2, 'name' => 'Самара' }] }
  let(:services) { [{ 'id' => 1, 'name' => 'Туалет' }, { 'id' => 2, 'name' => 'WiFi' }] }
  let(:trips) do
    [
      { 'id' => 1, 'from_id' => 1, 'to_id' => 2, 'start_time' => '11:00', 'duration_minutes' => 168, 'price_cents' => 474, 'bus_id' => 1 },
      { 'id' => 2, 'from_id' => 2, 'to_id' => 1, 'start_time' => '17:30', 'duration_minutes' => 37, 'price_cents' => 173, 'bus_id' => 1 },
      { 'id' => 3, 'from_id' => 1, 'to_id' => 2, 'start_time' => '12:00', 'duration_minutes' => 323, 'price_cents' => 672, 'bus_id' => 1 },
      { 'id' => 4, 'from_id' => 2, 'to_id' => 1, 'start_time' => '18:30', 'duration_minutes' => 315, 'price_cents' => 969, 'bus_id' => 1 },
      { 'id' => 5, 'from_id' => 1, 'to_id' => 2, 'start_time' => '13:00', 'duration_minutes' => 304, 'price_cents' => 641, 'bus_id' => 1 },
      { 'id' => 6, 'from_id' => 2, 'to_id' => 1, 'start_time' => '19:30', 'duration_minutes' => 21, 'price_cents' => 663, 'bus_id' => 1 },
      { 'id' => 7, 'from_id' => 1, 'to_id' => 2, 'start_time' => '14:00', 'duration_minutes' => 598, 'price_cents' => 629, 'bus_id' => 1 },
      { 'id' => 8, 'from_id' => 2, 'to_id' => 1, 'start_time' => '20:30', 'duration_minutes' => 292, 'price_cents' => 22, 'bus_id' => 1 },
      { 'id' => 9, 'from_id' => 1, 'to_id' => 2, 'start_time' => '15:00', 'duration_minutes' => 127, 'price_cents' => 795, 'bus_id' => 1 },
      { 'id' => 10, 'from_id' => 2, 'to_id' => 1, 'start_time' => '21:30', 'duration_minutes' => 183, 'price_cents' => 846, 'bus_id' => 1 }
    ]
  end

  it 'imports data to database' do
    expect { import_data }
      .to change(Bus, :count).by(1)
      .and change(BusesService, :count).by(2)
      .and change(City, :count).by(2)
      .and change(Service, :count).by(2)
      .and change(Trip, :count).by(10)

    expect(Bus.all.map(&:attributes)).to eq(buses)
    expect(BusesService.all.map(&:attributes)).to eq(buses_services)
    expect(City.all.map(&:attributes)).to eq(cities)
    expect(Service.all.map(&:attributes)).to eq(services)
    expect(Trip.all.map(&:attributes)).to eq(trips)
  end
end
