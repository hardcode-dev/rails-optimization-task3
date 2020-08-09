require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  let(:bus) { FactoryBot.create(:bus) }
  let(:from_city) { FactoryBot.create(:city) }
  let(:to_city) { FactoryBot.create(:city) }
  let!(:trips) { FactoryBot.create_list(:trip, 3, from_id: from_city.id, to_id: to_city.id, bus_id: bus.id) }

  describe 'GET #index' do
    before { get :index, params: { from: from_city.name, to: to_city.name } }

    it 'Возврат http success' do
      expect(response).to have_http_status :success
    end

    it 'Переменная @from содержит город из параметра from' do
      expect(assigns(:from)).to eq from_city
    end

    it 'Переменная @to содержит город из параметра to' do
      expect(assigns(:to)).to eq to_city
    end

    it 'Возврат массива маршрутов' do
      expect(assigns(:trips)).to match_array(trips)
    end

    it 'Возврат index шаблона' do
      expect(response).to render_template :index
    end
  end
end
