# frozen_string_literal: true

require 'rails_helper'
Rails.application.load_tasks
RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

context 'example file' do
  it 'correct records count' do
    Rake::Task['reload_json'].invoke('fixtures/example.json')

    expect(Trip.count).to eq(10)
    expect(Bus.count).to eq(1)
    expect(Service.count).to eq(2)
    expect(BusesService.count).to eq(2)
  end
end

context 'large file' do
  # for the tests to work correctly, run it separately
  it 'faster then 60 sec' do
    expect { Rake::Task['reload_json'].invoke('fixtures/large.json') }.to perform_under(60).sec
  end
end
