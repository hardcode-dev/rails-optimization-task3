require 'rails_helper'

describe "rake reload_json[fixtures/small.json]" do
  context 'performs 1000 lines under 12s' do
    it {
      expect {
        Rake::Task['reload_json'].invoke('fixtures/small.json')
      }.to perform_under(12).warmup(0).times

      expect(Trip.count).to eq(1000)
    }
  end
end
