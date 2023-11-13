require_relative '../test_helper'
require 'rspec/rails'

RSpec.describe TripsController, type: :controller do
  describe 'GET trips#index' do
    # RAILS_ENV=test rake reload_json[fixtures/large.json]
    before(:all) do
      Rake::Task.define_task(:environment)
      Rake::Task['reload_json'].invoke('fixtures/large.json')
    end

    def subject
      get :index, params: { from: 'Самара', to: 'Москва' }
    end

    it 'should not raise errors' do
      subject

      expect(response).to have_http_status(:success)
    end

    # 100k trips under 1.6 ms from DB / without view rendering
    it 'should work under 1.6 ms' do
      expect { subject }.to perform_under(1.6).ms
    end

    it 'has correct number of trips from large json' do
      subject

      expect(@controller.view_assigns['trips'].size).to eq(1004)
    end
  end
end
