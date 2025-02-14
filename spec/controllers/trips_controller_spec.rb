# frozen_string_literal: true

RSpec.describe TripsController do
  render_views

  describe "GET #index" do
    let!(:from) { create :city }
    let!(:to) { create :city }

    before do
      create_list(:trip, 10, from:, to:)
    end

    subject(:perform) { get :index, params: { from: from.name, to: to.name } }
  
    it { is_expected.to be_successful }

    context "performance" do
      before do
        create_list(:trip, 2000, from:, to:)
      end
  
      it "works with large data under 1 sec" do
        time = Benchmark.realtime do
          perform
        end
    
        expect(time).to be < 1
      end
    end
  end
end