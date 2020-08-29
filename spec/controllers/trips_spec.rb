require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe 'GET #index' do
    before { DbImport.import('fixtures/example.json') }

    subject { get :index, params: { from: 'Самара', to: 'Москва' } }

    it 'N+1' do
      expect { subject }.not_to exceed_query_limit(2)
    end
  end
end
