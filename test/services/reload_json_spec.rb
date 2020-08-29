require_relative '../test_helper.rb'

describe ReloadJson do
  subject(:call_service) { described_class.new.call('fixtures/example.json') }
  describe '#call' do
    let(:expected_cities) { %W(Москва Самара) }
    let(:expected_buses) { [%W(123 Икарус)] }
    let(:expected_services) { %W(Туалет WiFi) }
    let(:expected_trips) do 
      [[1, 2, "11:00", 168, 474, 1],
       [2, 1, "17:30", 37, 173, 1],
       [1, 2, "12:00", 323, 672, 1],
       [2, 1, "18:30", 315, 969, 1],
       [1, 2, "13:00", 304, 641, 1],
       [2, 1, "19:30", 21, 663, 1],
       [1, 2, "14:00", 598, 629, 1],
       [2, 1, "20:30", 292, 22, 1],
       [1, 2, "15:00", 127, 795, 1],
       [2, 1, "21:30", 183, 846, 1]]
    end

    it 'creates expected cities' do
      expect { call_service }.to change { City.pluck(:name) }.from([]).to(expected_cities)
    end
    it 'creates expected buses' do
      expect { call_service }.to change { Bus.pluck(:number, :model) }.from([]).to(expected_buses)
    end
    it 'creates expected serices' do
      expect { call_service }.to change { Service.pluck(:name) }.from([]).to(expected_services)
    end
    it 'creates expected trips' do
      expect { call_service }.to change {
        Trip.pluck(:from_id, :to_id, :start_time, :duration_minutes, :price_cents, :bus_id)
      }.from([]).to(expected_trips)
    end
  end
end
