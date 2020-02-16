require 'rails_helper'
Rails.application.load_tasks

describe 'reload_json' do
  it 'checks counts' do
    Rake::Task['reload_json'].invoke('fixtures/example.json')

    expect(Service.count).to eq 2
    expect(Trip.count).to eq 10
    expect(Bus.count).to eq 1
    Bus.all.each do |bus|
      expect(bus.services.to_a.sort).to eq Service.all.to_a.sort
    end
  end
end
