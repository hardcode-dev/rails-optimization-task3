require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe 'GET #index' do
    before do
      Rake::Task['reload_json'].reenable
      Rake::Task['reload_json'].invoke('fixtures/medium.json')
    end

    def do_request
      get :index, params: { from: 'Самара', to: 'Москва' }
    end

    it 'успешно отображается' do
      expect { do_request }.to perform_under(6).ms
      expect(response).to have_http_status(:success)
    end
  end
end
