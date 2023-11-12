require_relative '../test_helper'
require 'json'

describe 'rake reload_json', type: :task do

  # 1k trips under 3.5 seconds
  it 'should work under 3.5 seconds' do
    expect { task.execute(Rake::TaskArguments.new([:file_name], ['fixtures/small.json'])) }.to perform_under(3.5).sec
  end

  # 10k trips under 65 seconds
  it 'should work under 65 seconds' do
    expect { task.execute(Rake::TaskArguments.new([:file_name], ['fixtures/medium.json'])) }.to perform_under(65).sec
  end

  # 100k trips under 60 seconds
  # it 'should work under 60 seconds' do
  #   expect { task.execute(Rake::TaskArguments.new([:file_name], ['fixtures/large.json'])) }.to perform_under(60).sec
  # end
end
