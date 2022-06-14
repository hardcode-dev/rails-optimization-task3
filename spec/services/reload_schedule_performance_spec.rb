require 'rails_helper'

RSpec.describe 'Performance ReloadSchedule' do
  let(:file_name) { 'fixtures/small.json' }

  it 'performs under 0.35 sec' do
    expect { ReloadSchedule.call(file_name: file_name) }.to perform_under(0.35).sec.warmup(2).times.sample(5).times
  end
end
