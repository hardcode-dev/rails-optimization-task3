require 'rails_helper'

RSpec.describe TripsController, type: :controller do

  describe 'GET #index' do
    before { ImportTripsService.call('fixtures/medium.json') }

    it 'load 10 000 trips under 5 ms' do
      expect { get :index, params: { from: 'Самара', to: 'Москва' } }.to perform_under(5).ms
    end
  end
end
