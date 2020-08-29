require 'rails_helper'

describe 'reload json task' do
  let(:bus_attrs) { {"id"=>1, "number"=>"123", "model"=>"Икарус"} }
  let(:service_names) { ["Туалет", "WiFi"] }
  let(:city_names) { ["Москва", "Самара"] }
  let(:first_trip_attrs) do
    {
      "id"=>1,
      "from_id"=>1,
      "to_id"=>2,
      "start_time"=>"11:00",
      "duration_minutes"=>168,
      "price_cents"=>474,
      "bus_id"=>1,
    }
  end

  before do
    `rake db:setup`
    `rake "reload_json[fixtures/example.json]"`
  end

  it 'creates all instances' do
    expect(City.count).to eq 2
    expect(Service.count).to eq 10
    expect(Bus.count).to eq 1
    expect(BusesServices.count).to eq 2
    expect(Trip.count).to eq 10
  end

  it 'creates correct instances' do
    bus_attrs.each do |k, v|
      expect(Bus.first.attributes[k]).to eq v
    end
    expect((Service.pluck(:name) & service_names).size).to eq 2
    expect((City.pluck(:name) & city_names).size).to eq 2
    first_trip_attrs.each do |k, v|
      expect(Trip.first.attributes[k]).to eq v
    end
  end
end
