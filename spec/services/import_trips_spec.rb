# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportTrips, :type => :service do
  describe '#call!' do
    subject(:import!) { described_class.new(filename).call! }

    let(:filename) { Rails.root.join('fixtures', 'example.json') }

    context 'with correctness' do
      before { import! }

      it 'check counts' do
        expect(City.count).to eq 2
        expect(Bus.count).to eq 1
        expect(Service.count).to eq 2
        expect(Trip.count).to eq 10
      end
    end

    context 'with benchmark' do
      it { expect { import! }.to perform_under(40).ms.sample(5).times }
    end
  end
end
