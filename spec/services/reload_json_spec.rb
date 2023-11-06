# frozen_string_literal: true

require 'rspec-benchmark'
require 'rails_helper'

RSpec.configure { |config| config.include RSpec::Benchmark::Matchers }

describe ReloadJson do
  it 'performs under certain time' do
    expect { described_class.new('fixtures/medium.json').call }.to perform_under(1000).ms.warmup(1).times
  end
end
