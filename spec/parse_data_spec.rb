require 'spec_helper.rb'

describe 'Programme work' do
  xcontext 'with small.json' do
    let(:trip_1_to_h) { {:from=>"Сочи", :to=>"Тула", :start_time=>"16:11", :duration_minutes=>83, :price_cents=>23354, :bus=>{:number=>"229", :model=>"Икарус", :services=>["Ремни безопасности", "Кондиционер общий", "Кондиционер Индивидуальный", "Телевизор индивидуальный", "Стюардесса", "Можно не печатать билет"].to_set}} }
    let(:trip_2_to_h) { {:from=>"Самара", :to=>"Самара", :start_time=>"13:13", :duration_minutes=>572, :price_cents=>83861, :bus=>{:number=>"912", :model=>"Вольво", :services=>["Телевизор индивидуальный", "Стюардесса", "Можно не печатать билет", "WiFi", "Работающий туалет"].to_set}} }
    let(:trip_last_to_h) { {:from=>"Волгоград", :to=>"Волгоград", :start_time=>"10:46", :duration_minutes=>395, :price_cents=>26867, :bus=>{:number=>"684", :model=>"ГАЗ", :services=>["Ремни безопасности", "Кондиционер общий", "Кондиционер Индивидуальный", "Телевизор индивидуальный", "Можно не печатать билет", "WiFi", "Туалет"].to_set}} }

    before { system 'rake reload_json[fixtures/small.json]' }

    it { expect(Trip.count).to eq 1000 }
    it { expect(Bus.count).to eq 613 }
    it { expect(City.count).to eq 10 }
    it { expect(Service.count).to eq 10 }

    it { expect(Trip.first.to_h).to eq trip_1_to_h }
    it { expect(Trip.second.to_h).to eq trip_2_to_h }
    it { expect(Trip.last.to_h).to eq trip_last_to_h }
  end

  context 'with example.json' do
    let(:trip_1_to_h) { {:bus=>{:model=>"Икарус", :number=>"123", :services=>["Туалет", "WiFi"].to_set}, :duration_minutes=>168, :from=>"Москва", :price_cents=>474, :start_time=>"11:00", :to=>"Самара"} }
    let(:trip_2_to_h) { {:bus=>{:model=>"Икарус", :number=>"123", :services=>["Туалет", "WiFi"].to_set}, :duration_minutes=>37, :from=>"Самара", :price_cents=>173, :start_time=>"17:30", :to=>"Москва"} }
    let(:trip_last_to_h) { {:bus=>{:model=>"Икарус", :number=>"123", :services=>["Туалет", "WiFi"].to_set}, :duration_minutes=>183, :from=>"Самара", :price_cents=>846, :start_time=>"21:30", :to=>"Москва"} }

    before { system 'rake reload_json[fixtures/example.json]' }

    it { expect(Trip.count).to eq 10 }
    it { expect(Bus.count).to eq 1 }
    it { expect(City.count).to eq 2 }
    it { expect(Service.count).to eq 10 }

    it { expect(Trip.first.to_h).to eq trip_1_to_h }
    it { expect(Trip.second.to_h).to eq trip_2_to_h }
    it { expect(Trip.last.to_h).to eq trip_last_to_h }
  end
end
