require 'rails_helper'

RSpec.describe ReloadSchedule do
  describe '.call' do
    subject { described_class.call(file_name: file_name) }

    let(:file_name) { 'fixtures/example.json' }

    it 'creates 10 trips' do
      expect { subject }.to change(Trip, :count).by(10)
    end

    it 'creates 2 cities' do
      expect { subject }.to change(City, :count).by(2)
    end

    it 'creates 2 services' do
      expect { subject }.to change(Service, :count).by(2)
    end

    it 'creates 2 buses' do
      expect { subject }.to change(Bus, :count).by(1)
    end
  end
end
