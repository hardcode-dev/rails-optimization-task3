require 'rails_helper'

RSpec::Benchmark.configure do |config|
  config.run_in_subprocess = false
end

RSpec.describe TripsController, :type => :controller do
  describe '#index' do
    subject { get :index, params: { from: 'Самара', to: 'Москва' } }

    let(:file_name) { Rails.root.join('fixtures', 'small.json') }

    describe 'benchmark' do
      it do
        ReloadJson.new(file_name).call
        expect { subject }.to perform_under(0.05).ms
        expect(assigns(:trips).size).to eq 13
      end
    end
  end
end