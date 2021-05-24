# frozen_string_literal: true

require 'rails_helper'

describe Jobs::Import::TripsJob do
  let(:filename) { 'fixtures/example.json' }
  let(:job) { described_class.new(filename)}

  describe "#perform" do
    it 'must create atleast 1 bus, 10 trips, 2 cities' do
      expect { job.call }.to change(Bus.all, :count).from(0).to(1)
        .and(change(Trip.all, :count).from(0).to(10))
        .and(change(City.all, :count).from(0).to(2))
    end
  end
  describe "perfomance time" do
    let(:filename) { 'fixtures/small.json' }
    it 'must work less a second' do
      expect{ job.call}.to perform_under(1.5).sec
    end
  end
end