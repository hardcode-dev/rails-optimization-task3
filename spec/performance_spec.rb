require 'rails_helper'
require 'rspec-benchmark'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

describe 'Performance' do
  it 'works under 1 min' do
    expect {
      system 'rake reload_json[fixtures/small.json]'
    }.to perform_under(5).sec
  end
end
