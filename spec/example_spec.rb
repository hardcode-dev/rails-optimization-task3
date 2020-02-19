require 'rails_helper'

describe 'reload example json' do
  before do
    system 'rails db:setup'
    system 'rake reload_json[fixtures/example.json]'
  end

  it 'creates correct number of models instances' do
    expect(Service.count).to eq 2
    expect(Trip.count).to eq 10
    expect(Bus.count).to eq 1
    Bus.all.each do |bus|
      expect(bus.services.to_a.sort).to eq Service.all.to_a.sort
    end
  end
end
