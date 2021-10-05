require 'rails_helper'

describe '.import' do
  it 'works under 6.5 sec for small file' do
    expect { Import.('fixtures/medium.json') }.to perform_under(6.5).sec.sample(5).times
  end
end
