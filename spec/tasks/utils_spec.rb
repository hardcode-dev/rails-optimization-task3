require 'rails_helper'
require 'rake'

describe ':reload_json' do
  it 'created correct data' do
    Rails.application.load_tasks

    expect {
      Rake::Task['reload_json'].invoke('spec/factories/files/import_example.json')
    }.to change(Bus, :count).by(1)
    .and change(City, :count).by(2)
    .and change(Service, :count).by(2)
    .and change(Trip, :count).by(10)

    expect(Bus.first.model).to eq('Икарус')
    expect(City.first.name).to eq('Москва')
    expect(Service.first.name).to eq('Туалет')
    expect(Trip.first.start_time).to eq('11:00')
  end
end