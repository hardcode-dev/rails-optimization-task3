require 'rails_helper'

RSpec.describe TripsReloadService do
  describe '#run' do
    let(:file_path) { Rails.root.join('fixtures', 'example.json') }
    context 'with correctness' do
      before do
        TripsReloadService.new(file_path).run
      end

      it 'all reference data is created' do
        expect(Bus.count).to eq 1
        expect(Trip.count).to eq 10
        expect(City.count).to eq 2
        expect(Service.count).to eq 2
        expect(Bus.take.services.count).to eq 2
      end
    end
  end
end
