require 'rails_helper'

describe 'reload_json', :rakefile => 'utils', type: :task do
  before { task.invoke 'fixtures/example.json' }

  it 'loads data from JSON file', :aggregate_failures do
    expect(City.count).to eq(2)
    expect(Bus.count).to eq(1)
    expect(Service.count).to eq(2)
    expect(Trip.count).to eq(10)
  end
end
