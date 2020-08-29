require 'rails_helper'

RSpec.describe DbImport do

  subject { described_class.import(file) }

  describe 'Import to all tables should be success' do
    let(:file) { 'fixtures/example.json' }

    it 'should imported into Bus 1 record' do
      expect { subject }.to change(Bus, :count).by(1)
    end

    it 'should imported into Service' do
      expect { subject }.to change(Service, :count).by(Service::SERVICES.size)
    end

    it 'should imported into City 2 records' do
      expect { subject }.to change(City, :count).by(2)
    end

    it 'should imported into Trip 10 records' do
      expect { subject }.to change(Trip, :count).by(10)
    end

    it 'should imported into RspecModels::BusesService 2 records' do
      expect { subject }.to change(BusesServices, :count).by(2)
    end
  end

  describe 'Benchmark should be success' do
    let(:file) { 'fixtures/small.json' }

    it { expect { subject }.to perform_under(700).ms }
  end
end
