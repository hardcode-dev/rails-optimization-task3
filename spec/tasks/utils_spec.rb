require 'rails_helper'

describe 'reload_json', :rakefile => 'utils', type: :task do
  before { task.invoke 'fixtures/example.json' }

  it { expect(City.count).to eq(2) }
  it { expect(Bus.count).to eq(1) }
  it { expect(Service.count).to eq(2) }
  it { expect(Trip.count).to eq(10) }
end
