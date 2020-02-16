require 'rails_helper'

RSpec.describe DbImport do

  subject { described_class.import('fixtures/example.json') }

  it 'should imported into Bus 1 record' do
    expect { subject }.to change(Bus, :count).by(1)
  end

  it 'should imported into Service 2 records' do
    expect { subject }.to change(Service, :count).by(2)
  end

  it 'should imported into City 2 records' do
    expect { subject }.to change(City, :count).by(2)
  end

  it 'should imported into Trip 10 records' do
    expect { subject }.to change(Trip, :count).by(10)
  end

  it 'should imported into RspecModels::BusesService 2 records' do
    expect { subject }.to change(RspecModels::BusesService, :count).by(2)
  end
end
