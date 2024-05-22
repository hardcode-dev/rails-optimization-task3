require 'rails_helper'

describe "ImportTripsService" do
  context 'Correct trips import' do
    let(:trip_from_file) { JSON.parse(File.read('fixtures/example.json')) }
    
    before { ImportTripsService.call('fixtures/example.json') }

    it 'trips from DB are equal to imported' do
      expect(Trip.all.map(&:to_h).sort_by(&:to_s)).to eq trip_from_file.sort_by(&:to_s)
    end    
  end

  it 'save trips in DB' do
    expect { ImportTripsService.call('fixtures/example.json') }.to change { Trip.count }.by(10)
  end
  
  it '1000 trips perform under 2 sec' do
    expect { ImportTripsService.call('fixtures/small.json') }.to perform_under(2).sec
  end
end
