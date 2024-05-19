require 'rails_helper'

describe "TripsImporter" do
  context 'performs 1000 lines under 12s' do
    it {
      expect {
        TripsImporter.call('fixtures/medium.json')
      }.to perform_under(1).warmup(0).times

      expect(Trip.count).to eq(1000)
    }
  end
end
