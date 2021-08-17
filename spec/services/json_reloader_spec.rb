require 'rails_helper'

RSpec.describe JsonReloader do
  context 'load data' do
    let(:file) { Rails.root.join('spec', 'data', 'example.json') }
    before { JsonReloader.new(file).call }

    it 'checking the number of objects' do
      expect(Bus.count)     .to eq(1)
      expect(City.count)    .to eq(2)
      expect(Service.count) .to eq(2)
      expect(Trip.count)    .to eq(10)
    end
  end
end

