require 'rails_helper'

describe ImportJson do
  subject { described_class.new('fixtures/example.json').perform }

  describe '#perform' do
    it 'creates right amount of cities' do
      expect { subject }.to change(City, :count).by(2)
    end

    it 'saves correct city attrs' do
      subject
      expect(City.all.pluck(:name)).to match_array(%w[Москва Самара])
    end

    it 'creates right amount of buses' do
      expect { subject }.to change(Bus, :count).by(1)
    end

    it 'saves correct bus attrs' do
      subject
      bus = Bus.last
      expect(bus.number).to eq 123
      expect(bus.model).to eq 'Икарус'
      expect(bus.services.count).to eq 2
    end

    it 'creates all services' do
      expect { subject }.to change(Service, :count).by(10)
    end

    it 'creates right amount of trips' do
      expect { subject }.to change(Trip, :count).by(10)
    end
  end
end
