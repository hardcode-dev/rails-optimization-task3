require 'rails_helper'

RSpec.describe ImportData do
  subject { described_class.run!(file_name: file_name) }
  let(:file_name) { 'fixtures/example.json' }

  describe '#execute' do
    context 'common' do
      it 'creates trips' do
        expect { subject }
          .to change { Trip.count }.by(10)
          .and change { City.count }.by(2)
          .and change { Service.count }.by(2) # 10
          .and change { Bus.count }.by(1)
          .and change { BusesService.count }.by(2)
      end

      it 'does not send unnecessary INSERT requests to db' do
        expect { subject }.not_to exceed_query_limit(5).with(/^INSERT/)
      end

      it 'does not send unnecessary SELECT requests to db' do
        expect { subject }.not_to exceed_query_limit(0).with(/^SELECT/)
      end

      it 'does not send unnecessary DELETE requests to db' do
        expect { subject }.not_to exceed_query_limit(5).with(/^DELETE/)
      end

      it 'works with better performance' do
        expect { subject }.to perform_under(8).us.warmup(2).times.sample(10).times
      end
    end
  end
end
