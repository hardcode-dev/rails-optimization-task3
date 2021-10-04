require 'rails_helper'

describe Importer do
  it 'imports data' do
    expect { Importer.new('fixtures/example.json').perform }
      .to change(Bus, :count).by(2).and change(City, :count).by(5).and change(Service, :count).by(3)
      .and change(Trip, :count).by(13).and change(BusesService, :count).by(4)
  end
end
