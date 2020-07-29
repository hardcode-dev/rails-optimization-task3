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
    end
  end
end
