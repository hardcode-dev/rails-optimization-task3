require 'rails_helper'
require 'rspec-benchmark'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

describe TripsController, type: :controller do
  describe 'GET #index' do

    before do
      system 'rails db:setup'
      system 'rake reload_json[fixtures/small.json]'
    end

    it 'responds with 200' do
      get :index, params: { from: 'Самара', to: 'Москва', format: :json }
      expect(response).to have_http_status(200)
    end

    it 'works under 1 ms' do
      expect {
        get :index, params: { from: 'Самара', to: 'Москва' }
      }.to perform_under(3).ms.warmup(1).times.sample(10).times
    end
  end
end