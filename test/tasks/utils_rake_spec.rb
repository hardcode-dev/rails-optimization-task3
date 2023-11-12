require_relative '../test_helper'

describe 'rake reload_json', type: :task do

  # 1k trips under 2.5 seconds
  it 'should work under 2.5 seconds' do
    expect { task.execute(Rake::TaskArguments.new([:file_name], ['fixtures/small.json'])) }.to perform_under(2.5).sec
  end

  # 10k trips under 5.5 seconds
  it 'should work under 5.5 seconds' do
    expect { task.execute(Rake::TaskArguments.new([:file_name], ['fixtures/medium.json'])) }.to perform_under(5.5).sec
  end

  # 100k trips under 18 seconds
  it 'should work under 18 seconds' do
    expect { task.execute(Rake::TaskArguments.new([:file_name], ['fixtures/large.json'])) }.to perform_under(18).sec
  end
end
