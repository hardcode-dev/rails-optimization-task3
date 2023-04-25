require 'rails_helper'

RSpec.describe ImportData do
  subject { described_class.run!(file_name: 'fixtures/example.json') }

  describe '#execute' do
    context 'common' do
      it 'creates trips' do
        expect { subject }
          .to change { Trip.count }.by(10)
          .and change { City.count }.by(2)
          .and change { Service.count }.by(2)
          .and change { Bus.count }.by(1)
      end
    end
  end
end
