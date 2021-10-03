require 'rails_helper'

describe Importer do
  it 'imports data' do
    expect { Importer.new('fixtures/example.json').perform }
      .to change(Bus, :count).by(1).and change(City, :count).by(2).and change(Trip, :count).by(10)
      .and change(Service, :count).by(2)
  end
end
