require 'rails_helper'

RSpec.describe JsonReloader do
  context 'load example data' do
    let(:example_file) { Rails.root.join('spec', 'data', 'example.json') }
    before { JsonReloader.new(example_file).call }

    it 'checking the number of objects' do
      expect(Bus.count)     .to eq(1)
      expect(City.count)    .to eq(2)
      expect(Service.count) .to eq(2)
      expect(Trip.count)    .to eq(10)
    end
  end

  describe 'Performance' do
    context 'load small data' do
      let(:small_file) { Rails.root.join('fixtures', 'small.json') }
      let(:small_budget) { 3_500 }

      it 'under budget (X sec)' do
        expect { JsonReloader.new(small_file).call }
          .to perform_under(small_budget).ms.warmup(1).times.sample(2).times
      end
    end

    context 'load large(budget) data' do
      let(:budget_file) { Rails.root.join('fixtures', 'large.json') }
      let(:budget) { 36_000 }

      it 'under budget (X sec)' do
        expect { JsonReloader.new(budget_file).call }
          .to perform_under(budget).ms.warmup(1).times.sample(2).times
      end
    end
  end
end
