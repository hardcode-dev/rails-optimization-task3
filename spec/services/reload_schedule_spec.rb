require 'rails_helper'

RSpec.describe ReloadSchedule do
  describe '.call' do
    subject { described_class.call(file_name: file_name) }

    let(:file_name) { 'fixtures/example.json' }

    context 'with Trip' do
      let(:expected_start_times) do
        %w[11:00 17:30 12:00 18:30 13:00 19:30 14:00 20:30 15:00 21:30]
      end
      let(:expected_duration_minutes) do
        [168, 37, 323, 315, 304, 21, 598, 292, 127, 183]
      end
      let(:expected_price_cents) do
        [474, 173, 672, 969, 641, 663, 629, 22, 795, 846]
      end

      it 'creates 10 trips' do
        expect { subject }.to change(Trip, :count).by(10)
      end

      it 'assigns correct attributes', :aggregate_failures do
        subject

        expect(Trip.all.pluck(:start_time)).to match_array expected_start_times
        expect(Trip.all.pluck(:duration_minutes)).to match_array expected_duration_minutes
        expect(Trip.all.pluck(:price_cents)).to match_array expected_price_cents
      end

      it 'assigns correct references', :aggregate_failures do
        subject

        trip = Trip.find_by(start_time: '11:00')

        expect(trip.from.name).to eq 'Москва'
        expect(trip.to.name).to eq 'Самара'
        expect(trip.bus.number).to eq '123'
        expect(trip.bus.model).to eq 'Икарус'
      end
    end


    context 'with City' do
      let(:moscow) { City.find_by(name: 'Москва') }
      let(:samara) { City.find_by(name: 'Самара') }

      it 'creates 2 cities' do
        expect { subject }.to change(City, :count).by(2)
      end

      it 'assigns correct attributes', :aggregate_failures do
        subject

        expect(moscow).to be_present
        expect(samara).to be_present
      end
    end


    context 'when Service' do
      let(:toilet) { Service.find_by(name: 'Туалет') }
      let(:wi_fi) { Service.find_by(name: 'WiFi') }

      it 'creates 2 services' do
        expect { subject }.to change(Service, :count).by(2)
      end

      it 'assigns correct attributes', :aggregate_failures do
        subject

        expect(toilet).to be_present
        expect(wi_fi).to be_present
      end
    end

    context 'when Bus' do
      let(:bus_123) { Bus.find_by(number: '123', model: 'Икарус') }

      it 'creates 2 buses' do
        expect { subject }.to change(Bus, :count).by(1)
      end

      it 'assigns correct attributes' do
        subject

        expect(bus_123).to be_present
      end
    end
  end
end
