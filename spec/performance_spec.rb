require 'rails_helper'

describe 'service class and rake task' do
  before do
    system 'rake reload_json[fixtures/small.json]'
    @cities_by_rake = City.all.pluck :name
    @services_by_rake = Service.all.pluck :name
    @buses_by_rake = Bus.all.pluck :number, :model
    @trips_by_rake = Trip.all.pluck :start_time, :duration_minutes, :price_cents
    
    ReloadJson.new('fixtures/small.json').call
    @cities_by_service = City.all.reload.pluck :name
    @services_by_service = Service.all.reload.pluck :name
    @buses_by_service = Bus.all.reload.pluck :number, :model
    @trips_by_service = Trip.all.reload.pluck :start_time, :duration_minutes, :price_cents
  end
  
  describe 'import identical data from the same file' do
    it 'for cities' do
      expect(@cities_by_rake).to match_array(@cities_by_service)
    end

    it 'for services' do
      expect(@services_by_rake).to match_array(@services_by_service)
    end

    it 'for buses' do
      expect(@buses_by_rake).to match_array(@buses_by_service)
    end

    it 'for trips' do
      expect(@trips_by_rake).to match_array(@trips_by_service)
    end
  end
end

describe 'service class' do
  it 'works under 1 min' do
    expect {
      ReloadJson.new('fixtures/large.json').call
    }.to perform_under(60).sec.warmup(1).times.sample(5).times
  end
end

