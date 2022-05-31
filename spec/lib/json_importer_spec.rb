# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

require_relative '../../lib/json_importer'

RSpec.describe JSONImporter do
  subject(:service) { described_class.new }

  describe 'work efficiency' do
    let(:path) { Rails.root.join('fixtures', 'small.json') }

    it 'matches the timing' do
      expect { service.call(path) }.to perform_under(0.2)
    end
  end

  describe 'result' do
    subject(:result) { service.call(path) }
    let(:path) { Rails.root.join('fixtures', 'example.json') }

    it 'creates cities' do
      expect { result }.to change(City, :count).by(2)
      expect(City).to be_exists(name: 'Москва').and(
                      be_exists(name: 'Самара')
      )
    end

    it 'creates services' do
      expect { result }.to change(Service, :count).by(2)
      expect(Service).to be_exists(name: 'Туалет').and(
                         be_exists(name: 'WiFi')
      )
    end

    it 'creates buses' do
      expect { result }.to change(Bus, :count).by(1)
      expect(Bus).to be_exists(model: 'Икарус', number: '123')
    end

    it 'creates bus with services' do
      result
      bus = Bus.where(model: 'Икарус', number: '123').last
      expect(bus.services.map(&:name)).to contain_exactly('Туалет', 'WiFi')
    end

    it 'creates trips for bus' do
      expect { result }.to change(Trip, :count).by(10)

      bus = Bus.where(model: 'Икарус', number: '123').last
      moscow = City.where(name: 'Москва').last
      samara = City.where(name: 'Самара').last

      [
        [['from_id', moscow.id], ['to_id', samara.id], ['start_time', '11:00'], ['duration_minutes', 168], ['price_cents', 474], ['bus_id', bus.id]],
        [['from_id', samara.id], ['to_id', moscow.id], ['start_time', '17:30'], ['duration_minutes', 37], ['price_cents', 173], ['bus_id', bus.id]],
        [['from_id', moscow.id], ['to_id', samara.id], ['start_time', '12:00'], ['duration_minutes', 323], ['price_cents', 672], ['bus_id', bus.id]],
        [['from_id', samara.id], ['to_id', moscow.id], ['start_time', '18:30'], ['duration_minutes', 315], ['price_cents', 969], ['bus_id', bus.id]],
        [['from_id', moscow.id], ['to_id', samara.id], ['start_time', '13:00'], ['duration_minutes', 304], ['price_cents', 641], ['bus_id', bus.id]],
        [['from_id', samara.id], ['to_id', moscow.id], ['start_time', '19:30'], ['duration_minutes', 21], ['price_cents', 663], ['bus_id', bus.id]],
        [['from_id', moscow.id], ['to_id', samara.id], ['start_time', '14:00'], ['duration_minutes', 598], ['price_cents', 629], ['bus_id', bus.id]],
        [['from_id', samara.id], ['to_id', moscow.id], ['start_time', '20:30'], ['duration_minutes', 292], ['price_cents', 22], ['bus_id', bus.id]],
        [['from_id', moscow.id], ['to_id', samara.id], ['start_time', '15:00'], ['duration_minutes', 127], ['price_cents', 795], ['bus_id', bus.id]],
        [['from_id', samara.id], ['to_id', moscow.id], ['start_time', '21:30'], ['duration_minutes', 183], ['price_cents', 846], ['bus_id', bus.id]]
      ].map(&:to_h).each do |trip|
        expect(Trip).to be_exists(trip)
      end
    end
  end
end
