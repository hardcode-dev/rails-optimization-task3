require 'rails_helper'
require 'rspec-benchmark'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

describe 'reload_json[fixtures/medium.json]' do
  it 'works under 10 s' do
    expect {
      ReloadJson.new('fixtures/medium.json').call
    }.to perform_under(10).sec.warmup(0).times.sample(1).times
  end
end

