require "rails_helper"
Rails.application.load_tasks

describe 'database seeder' do

  it 'process small.json file for under 3 sec' do
    expect {DatabaseSeeder.new('fixtures/small.json')}.to perform_under(3000).ms.sample(1).times
  end

  xit 'process large.json file for under 60 sec' do
    expect {DatabaseSeeder.new('fixtures/large.json')}.to perform_under(60000).ms.sample(1).times
  end

  it 'process small.json correctly' do
    DatabaseSeeder.new('fixtures/small.json')
    expect(City.count).to eq 10
    expect(Bus.count).to eq 613
    expect(Service.count).to eq 10
    expect(BusesService.count).to eq 2632
    expect(Trip.count).to eq 1000
  end

end