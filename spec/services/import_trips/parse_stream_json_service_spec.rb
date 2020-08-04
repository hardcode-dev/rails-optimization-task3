# frozen_string_literal: true

require 'rails_helper'

describe ImportTrips::ParseStreamJsonService do
  describe '#call' do
    it 'creates 5 trip records, 1 bus and 2 services from file' do
      described_class.new(file_path: 'fixtures/example.json').call

      expect(Trip.count).to eq(10)
      expect(Bus.count).to eq(1)
      expect(Service.count).to eq(2)
    end

    it 'equals created trips with example.json' do
      described_class.new(file_path: 'fixtures/example.json').call

      expect(JSON.parse(Trip.includes(:bus, :from, :to).map(&:to_h).to_json)).to eq(JSON.parse(File.read('fixtures/example.json')))
    end
  end
end
