require 'rails_helper'

describe TripsController, type: :controller do
  describe 'GET #index' do

    before do
      system 'rails db:setup'
      system 'rake reload_json[fixtures/small.json]'
    end

    it 'responds with 200' do
      get :test, params: { from: 'Самара', to: 'Москва', format: :json }
      expect(response).to have_http_status(200)
      response.body.should == '[{"id":693,"from_id":3,"to_id":8,"start_time":"12:18","duration_minutes":509,"price_cents":56316,"bus_id":497},{"id":755,"from_id":3,"to_id":8,"start_time":"13:19","duration_minutes":208,"price_cents":76148,"bus_id":136},{"id":759,"from_id":3,"to_id":8,"start_time":"13:22","duration_minutes":231,"price_cents":24918,"bus_id":527},{"id":890,"from_id":3,"to_id":8,"start_time":"13:31","duration_minutes":399,"price_cents":15785,"bus_id":579},{"id":241,"from_id":3,"to_id":8,"start_time":"15:19","duration_minutes":325,"price_cents":14983,"bus_id":190},{"id":790,"from_id":3,"to_id":8,"start_time":"15:46","duration_minutes":427,"price_cents":34762,"bus_id":538},{"id":433,"from_id":3,"to_id":8,"start_time":"15:49","duration_minutes":231,"price_cents":68632,"bus_id":350},{"id":630,"from_id":3,"to_id":8,"start_time":"17:19","duration_minutes":15,"price_cents":83359,"bus_id":462},{"id":966,"from_id":3,"to_id":8,"start_time":"17:26","duration_minutes":28,"price_cents":13132,"bus_id":517},{"id":813,"from_id":3,"to_id":8,"start_time":"17:37","duration_minutes":533,"price_cents":37888,"bus_id":336},{"id":631,"from_id":3,"to_id":8,"start_time":"19:35","duration_minutes":263,"price_cents":16995,"bus_id":463},{"id":772,"from_id":3,"to_id":8,"start_time":"19:42","duration_minutes":317,"price_cents":36337,"bus_id":530},{"id":173,"from_id":3,"to_id":8,"start_time":"22:41","duration_minutes":375,"price_cents":81838,"bus_id":156}]'
    end
  end
end