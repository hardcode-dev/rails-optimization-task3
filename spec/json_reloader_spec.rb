require 'rails_helper'

describe 'json_reloader' do
  let(:data) { Rails.root.join('fixtures', 'example.json') }

  it 'works under 20 ms' do
    expect {
      JsonReloader.new(data).call
    }.to perform_under(20).ms.warmup(2).times.sample(10).times
  end

  it 'should load data' do
    JsonReloader.new(data).call

    expect(City.count).to eq 2
    expect(Bus.count).to eq 1
    expect(Service.count).to eq 2
    expect(Trip.count).to eq 10
  end
end