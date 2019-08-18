describe TripsController, type: :controller do
  let!(:trip) { create(:trip) }

  describe 'GET #автобусы/Самара/Москва' do
    before do
      get :index, params: { from: 'Москва', to: 'Вигодощи' }
    end

    it 'status 200' do
      expect(response).to be_ok
    end

    it 'should return city for @from' do
      expect(assigns(:from)).to eq trip.from
    end
    it 'should return city for @to' do
      expect(assigns(:to)).to eq trip.to
    end
    it 'should return trips for @trips' do
      expect(assigns(:trips)).to eq [trip]
    end

    it 'render view index' do
      expect(response).to render_template :index
    end
  end
end
