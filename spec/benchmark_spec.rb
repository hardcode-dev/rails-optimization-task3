# frozen_string_literal: true

require 'benchmark'
require 'rspec-benchmark'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

describe 'rake#reload_json' do
  it 'works under 5 sec' do
    expect { `rake reload_json[fixtures/small.json]` }.to perform_under(5).sec
  end
end
