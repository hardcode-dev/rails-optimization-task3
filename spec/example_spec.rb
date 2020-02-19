require 'rails_helper'

describe 'reload example json' do
  before do
    system 'rails db:setup'
    system 'rake reload_json[fixtures/example.json]'
  end

  it 'creates correct number of models instances' do
    expect(Bus.count).to eq 1
    expect(City.count).to eq 2
    expect(BusesService.count).to eq 2
    expect(Trip.count).to eq 10
  end

  it 'creates correct models instances' do
    expect(Bus.first.number).to eq '123'
    expect(Bus.first.model).to eq 'Икарус'
    expect(City.pluck(:name)).to eq ["Москва", "Самара"]
    expect(BusesService.all.map{|bs| bs.service.name}).to eq ["Туалет", "WiFi"]
    expect(Trip.all.map{|t| {start_time: t.start_time,
      duration_minutes: t.duration_minutes, price_cents: t.price_cents}})
      .to eq [{:start_time=>"11:00", :duration_minutes=>168, :price_cents=>474},
              {:start_time=>"17:30", :duration_minutes=>37, :price_cents=>173},
              {:start_time=>"12:00", :duration_minutes=>323, :price_cents=>672},
              {:start_time=>"18:30", :duration_minutes=>315, :price_cents=>969},
              {:start_time=>"13:00", :duration_minutes=>304, :price_cents=>641},
              {:start_time=>"19:30", :duration_minutes=>21, :price_cents=>663},
              {:start_time=>"14:00", :duration_minutes=>598, :price_cents=>629},
              {:start_time=>"20:30", :duration_minutes=>292, :price_cents=>22},
              {:start_time=>"15:00", :duration_minutes=>127, :price_cents=>795},
              {:start_time=>"21:30", :duration_minutes=>183, :price_cents=>846}]
  end
end
