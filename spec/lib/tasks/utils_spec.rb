# frozen_string_literal: true

require 'rake'

RSpec.describe 'Tasks' do
  describe 'reload_json[fixtures/small.json]' do
    before do
      Rake.application.rake_require 'tasks/utils'
      Rake::Task.define_task(:environment)
    end

    it 'выполняется без ошибок' do
      Rake.application.invoke_task 'reload_json[fixtures/small.json]'
      from = City.find_by(name: 'Самара')
      to = City.find_by(name: 'Москва')
      trips = Trip.where(from: from, to: to)
      expect(trips.count).to eq 13
      expect(City.count).to eq 10
      expect(Service.count).to eq 10
      expect(Bus.count).to eq 613
      expect(Trip.count).to eq 1000
      expect(
        Bus.find_by(number: '160').staffings.pluck(:service_id)
      ).to eq ["WiFi", "Работающий туалет", "Кондиционер общий", "Кондиционер Индивидуальный", "Телевизор общий"]
    end
  end
end
