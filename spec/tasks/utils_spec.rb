require 'rake'

RSpec.describe 'reload_json', type: :task do
  let(:task_name) { 'reload_json' }
  let(:file) { "fixtures/example.json" }

  before do
    Rake.application.rake_require('tasks/utils')
    Rake::Task.define_task(:environment)
  end

  after do
    Rake::Task[task_name].reenable
  end

  subject(:task) { Rake::Task[task_name] }

  it "creates cities, buses and trips" do
    expect {
      task.invoke(file)
    }.to change { City.count }.by(2).and(
         change { Service.count }.by(2).and(
         change { Bus.count }.by(1).and(
         change { Trip.count }.by(10).and(
         change { Trip.includes(:from, :to).where(from: { name: "Москва" }, to: { name: "Самара" }).count }.by(5)))))
  end

  context "performance" do
    let(:file) { "fixtures/large.json" }

    it 'works with large data under 10 sec' do
      expect(File.size(file)).to be > 30 * 1024 * 1024 # 30 МБ
      expect { task.invoke(file) }.to perform_under(10).sec
    end
  end
end