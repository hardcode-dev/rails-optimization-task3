require 'rails_helper'

RSpec.describe ReloadJson, :type => :service do
  describe '#call' do
    subject { described_class.new(file_name).call }

    let(:file_name) { Rails.root.join('fixtures', 'example.json') }

    describe 'validity' do
      it 'saves records' do
        subject
        expect(City.count).to eq 2
        expect(Bus.count).to eq 1
        expect(Service.count).to eq 2
        expect(Trip.count).to eq 10
        expect(Trip.first.from.name).to eq 'Москва'
        expect(Trip.first.to.name).to eq 'Самара'
        expect(Bus.first.services.count).to eq 2
      end
    end

    describe 'benchmark' do
      it { expect { subject }.to perform_under(25).ms.warmup(5).times.sample(10).times }
    end
  end
end