require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe 'GET #index' do
    let!(:city_from) { create(:city, name: 'Samara') }
    let!(:city_to) { create(:city, name: 'Moscow') }
    let!(:trip) { create(:trip, from: city_from, to: city_to, start_time: 1.day.from_now) }
    let!(:other_trip) { create(:trip, from: create(:city), to: create(:city)) }

    context 'with valid city names' do
      before do
        get :index, params: { from: 'Samara', to: 'Moscow' }
      end

      it 'returns http success', :aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(assigns(:from)).to eq(city_from)
        expect(assigns(:to)).to eq(city_to)
        expect(assigns(:trips)).to eq([trip])
        expect(response).to render_template(:index)
      end
    end
  end
end
