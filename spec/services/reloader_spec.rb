# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reloader do
  describe '.reload' do
    subject(:reload_data) { described_class.reload(json_file_path) }

    let(:json_file_path) { file_fixture('example.json') }

    it 'clears existing data'  do
      City.create!(name: 'DummyCity')
      reload_data

      expect(City.find_by(name: 'DummyCity')).to be_nil
    end

    it 'loads trips data from JSON and create records in DB' do
      reload_data

      expect(City.count).to eq(2)
      expect(Bus.count).to eq(1)
      expect(Service.count).to eq(2)
      expect(Trip.count).to eq(10)

      moscow = City.find_by(name: 'Москва')
      expect(moscow).to be_present

      bus = Bus.find_by(number: '123')
      expect(bus).to be_present
      expect(bus.model).to eq('Икарус')
      expect(bus.services.map(&:name).uniq.size).to eq(bus.services.size)
    end
  end
end
