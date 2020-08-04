# frozen_string_literal: true

require 'rails_helper'

describe ImportTrips::ParseJsonService do
  describe '#call' do
    context 'performance' do
      it 'works under 50ms' do
        expect { described_class.call(file_path: 'fixtures/example.json') }.to perform_under(15).ms
      end
    end

    it 'creates 5 trip records, 1 bus and 2 services from file' do
      described_class.call(file_path: 'fixtures/example.json')

      expect(Trip.count).to eq(10)
      expect(Bus.count).to eq(1)
      expect(Service.count).to eq(2)
    end

    it 'equals created trips with example.json' do
      described_class.call(file_path: 'fixtures/example.json')

      expect(JSON.parse(Trip.includes(:bus, :from, :to).map(&:to_h).to_json)).to eq(JSON.parse(File.read('fixtures/example.json')))
    end
  end
end
