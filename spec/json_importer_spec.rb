# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe JsonImporter do
  subject(:service) { described_class.new }

  describe "execution time" do
    let(:file_path) { Rails.root.join('fixtures', 'small.json') }

    it 'executes less than expected time' do
      expect { service.call(file_name: file_path) }.to perform_under(1)
    end
  end

  describe "file import" do
    let(:path) { Rails.root.join('fixtures', 'example.json') }

    before do
      service.call(file_name: path)
    end

    it "creates cities" do
      expect(City.count).to eq(2)
      expect(City.all.pluck(:name)).to contain_exactly("Москва", "Самара")
    end

    it "creates buses" do
      expect(Bus.count).to eq(1)
      expect(Bus).to be_exists(model: 'Икарус', number: '123')
    end

    it "creates services" do
      expect(Service.count).to eq(2)
      expect(Service.pluck(:name)).to contain_exactly("Туалет", "WiFi")
    end

    it "creates services for the bus" do
      bus = Bus.where(model: 'Икарус', number: '123').last
      expect(bus.services.map(&:name)).to contain_exactly('Туалет', 'WiFi')
    end

    it "creates trips for bus" do
      expect(Trip.count).to eq(10)

      bus_id = Bus.first.id
      moscow_id = City.where(name: 'Москва').first.id
      samara_id = City.where(name: 'Самара').first.id

      expected_result = [
        {"from_id"=>moscow_id, "to_id"=>samara_id, "start_time"=>"11:00", "duration_minutes"=>168, "price_cents"=>474, "bus_id"=>bus_id},
        {"from_id"=>samara_id, "to_id"=>moscow_id, "start_time"=>"17:30", "duration_minutes"=>37, "price_cents"=>173, "bus_id"=>bus_id},
        {"from_id"=>moscow_id, "to_id"=>samara_id, "start_time"=>"12:00", "duration_minutes"=>323, "price_cents"=>672, "bus_id"=>bus_id},
        {"from_id"=>samara_id, "to_id"=>moscow_id, "start_time"=>"18:30", "duration_minutes"=>315, "price_cents"=>969, "bus_id"=>bus_id},
        {"from_id"=>moscow_id, "to_id"=>samara_id, "start_time"=>"13:00", "duration_minutes"=>304, "price_cents"=>641, "bus_id"=>bus_id},
        {"from_id"=>samara_id, "to_id"=>moscow_id, "start_time"=>"19:30", "duration_minutes"=>21, "price_cents"=>663, "bus_id"=>bus_id},
        {"from_id"=>moscow_id, "to_id"=>samara_id, "start_time"=>"14:00", "duration_minutes"=>598, "price_cents"=>629, "bus_id"=>bus_id},
        {"from_id"=>samara_id, "to_id"=>moscow_id, "start_time"=>"20:30", "duration_minutes"=>292, "price_cents"=>22, "bus_id"=>bus_id},
        {"from_id"=>moscow_id, "to_id"=>samara_id, "start_time"=>"15:00", "duration_minutes"=>127, "price_cents"=>795, "bus_id"=>bus_id},
        {"from_id"=>samara_id, "to_id"=>moscow_id, "start_time"=>"21:30", "duration_minutes"=>183, "price_cents"=>846, "bus_id"=>bus_id}
      ]

      expected_result.each do |result|
        expect(Trip).to be_exists(result)
      end
    end
  end
end
