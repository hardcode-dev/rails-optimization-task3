require 'rails_helper'

describe 'reload_json', :rakefile => 'utils', type: :task do
  before do
    allow(DataLoader).to receive(:load)

    task.invoke 'fixtures/example.json'
  end

  it { expect(DataLoader).to have_received(:load).with('fixtures/example.json') }
end
