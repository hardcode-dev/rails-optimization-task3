require 'rails_helper'
require 'rspec-benchmark'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

describe 'Performance' do
  it 'works under 35 sec' do
    expect {
      system 'rake reload_json[fixtures/large.json]'
    }.to perform_under(35).sec.warmup(1).times.sample(5).times
  end
end

