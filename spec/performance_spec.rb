require 'rails_helper'

describe 'reload_json[fixtures/large.json]' do
  it 'works under 1 min' do
    expect {
      ReloadJson.new('fixtures/large.json').call
    }.to perform_under(60).sec.warmup(1).times.sample(10).times
  end
end

