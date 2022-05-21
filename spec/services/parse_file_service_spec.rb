# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

describe ParseFileService do
  describe '#call' do
    xit 'works with SMALL under 3 sec' do
      expect { ParseFileService.new('fixtures/small.json').call }.to perform_under(3).sec
    end

    xit 'works with MEDIUM under 10 sec' do
      expect { ParseFileService.new('fixtures/medium.json').call }.to perform_under(10).sec
    end

    it 'works with LARGE under 40 sec' do
      expect { ParseFileService.new('fixtures/large.json').call }.to perform_under(40).sec
    end
  end
end
