# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataImporter do
  describe '.call' do
    before do
      described_class.call('fixtures/example.json')
    end

    it 'returns cities count' do
      expect(City.count).to eq(2)
    end

    it 'returns cities names' do
      expect(City.all.map(&:name)).to match_array(%w[Москва Самара])
    end

    it 'returns buses count' do
      expect(Bus.count).to eq(1)
    end

    it 'returns buses' do
      expect(Bus.all.map { |bus| bus.as_json(only: %i[model number]) }).to match_array([{ 'number' => '123', 'model' => 'Икарус'}])
    end

    it 'returns services count' do
      expect(Service.all.map(&:name)).to match_array(Service::SERVICES)
    end

    it 'returns trips count' do
      expect(Trip.count).to eq(10)
    end
  end
end
