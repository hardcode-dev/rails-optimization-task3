# frozen_string_literal: true
require 'rails_helper'

describe 'reload_json.rake' do
  let(:args) { Struct.new(:file_name) }
  before { Rails.application.load_tasks }

  describe 'Clean up' do
    it 'should clean up DB on execution' do
      expect(City).to receive(:delete_all)
      expect(Bus).to receive(:delete_all)
      expect(Service).to receive(:delete_all)
      expect(Trip).to receive(:delete_all)

      Rake::Task['reload_json'].execute(args.new(file_fixture('test.json')))
    end
  end

  describe 'records' do
    it 'should create expected number of records' do
      Rake::Task['reload_json'].execute(args.new(file_fixture('test.json')))

      expect(Bus.count).to eq 49
      expect(City.count).to eq 10
      expect(Service.count).to eq 10
      expect(Trip.count).to eq 50
    end
  end
end