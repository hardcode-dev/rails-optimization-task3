# frozen_string_literal: true

require 'rails_helper'

describe 'import JSON' do
  let(:file_name) { Rails.root.join('fixtures', 'example.json') }

  it 'works under 10 ms' do
    expect { ImportJSONService.perform(file_name) }.to perform_under(10).ms.warmup(2).times.sample(10).times
  end

  it 'loads all data' do
    ImportJSONService.perform(file_name)
    expect(City.count).to eq 2
    expect(Bus.count).to eq 1
    expect(Service.count).to eq 2
    expect(Trip.count).to eq 10
  end
end
