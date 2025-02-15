require 'rails_helper'
require 'rake'

RSpec.describe 'reload_json', type: :task do
  before do
    Rake.application.rake_require('tasks/utils')
    Rake::Task.define_task(:environment)
  end

  after { Rake::Task['reload_json'].reenable }

  subject(:task) { Rake::Task['reload_json'] }

  context 'check logic' do
    let(:file) { 'fixtures/example.json' }

    it 'created Cities, Service, Buses and Trips' do
      expect {
        task.invoke(file)
      }.to change { City.count }.by(2).and(
          change { Service.count }.by(2).and(
          change { Bus.count }.by(1).and(
          change { Trip.count }.by(10))))
    end
  end

  context "performance small" do
    let(:file) { "fixtures/small.json" }

    it 'works with large data under 2 sec' do
      expect { task.invoke(file) }.to perform_under(1.5).sec
    end
  end

  context "performance large" do
    let(:file) { "fixtures/large.json" }

    it 'works with large data under 60 sec' do
      expect { task.invoke(file) } .to perform_under(60).sec
    end
  end
end