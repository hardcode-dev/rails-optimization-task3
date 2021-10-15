require "rails_helper"


describe 'DatabaseStreamWriter' do

  it 'process small.json file for under 3 sec' do
    expect {DatabaseStreamWriter.new('fixtures/small.json').write}.to perform_under(3000).ms.sample(1).times
  end

  xit 'process large.json file for under 13 sec' do
    expect {DatabaseStreamWriter.new('fixtures/large.json').write}.to perform_under(13000).ms.sample(1).times
  end

  it 'process small.json correctly' do
    DatabaseStreamWriter.new('fixtures/small.json').write
    expect(City.count).to eq 10
    expect(Bus.count).to eq 613
    expect(Service.count).to eq 10
    expect(BusesService.count).to eq 2632
    expect(Trip.count).to eq 1000
  end

end