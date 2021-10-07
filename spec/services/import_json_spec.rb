require 'rails_helper'

describe ImportJson do

  subject { described_class.perform('fixtures/example.json') }

  describe '#perform' do
    it 'performs' do
      expect { subject }.to_not raise_exception
    end

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
      expect(bus.number).to eq '123'
      expect(bus.model).to eq 'Икарус'
    end

    it 'creates right amount of services' do
      expect { subject }.to change(Service, :count).by(2)
    end

    it 'saves correct service attrs' do
      subject
      expect(Service.all.pluck(:name)).to match_array(%w[Туалет WiFi])
    end

    it 'creates right amount of trips' do
      expect { subject }.to change(Trip, :count).by(10)
    end
  end
end
