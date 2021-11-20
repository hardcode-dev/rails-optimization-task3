# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonReloader do
  subject { described_class.new(file_name) }
  let(:file_name) { 'fixtures/example.json' }
  let(:source) { JSON(File.read(file_name)) }
  let(:expected_cities) do
    source.flat_map { |item| item.slice('from', 'to').values }.uniq.sort
  end

  context 'SUCCESS cases' do
    before do
      subject.call
    end

    it 'creates cities' do
      expect(City.all.pluck(:name).sort).to eq(expected_cities)
    end

    it 'creates buses' do
      aggregate_failures do
        source.each do |item|
          bus = Bus.find_by(number: item.dig('bus', 'number'))
          expect(bus.model).to eq(item.dig('bus', 'model'))
          expect(bus.services.pluck(:name).sort).to eq(item.dig('bus', 'services').sort)
        end
      end
    end

    it 'creates trips' do
      aggregate_failures do
        source.each do |item|
          attrs = item.slice('start_time', 'duration_minutes', 'price_cents').symbolize_keys
          expect(Trip.find_by(**attrs)).to_not be_nil
        end
      end
    end
  end

  context 'performance' do
    let(:file_name) { 'fixtures/medium.json' }
    let(:tables_count) { 5 }

    it "doesn't send unnecessary requests to db" do
      expect { subject.call }.not_to exceed_query_limit(15)
    end

    it 'does only bulk insert' do
      expect { subject.call }.not_to exceed_query_limit(tables_count).with(/^INSERT/)
    end

    it 'works fast' do
      expect { subject.call }.to perform_under(3).sec
    end
  end
end
