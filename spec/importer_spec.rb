require_relative 'rspec_helper'

describe 'Performance reporter' do
  let(:file_path) { 'fixtures/large.json' }
  let(:time) { 1 }
  let(:strem) { File.open(file_path) }
  
  it 'create report' do
    expect {
      Importer.call(stream)
    }.to perform_under(time).sec.warmup(60).times.sample(10).times
  end  
end
