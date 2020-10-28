# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

describe 'reload_json_performance' do
  subject(:task) { Rake::Task['reload_json'].invoke(file) }
  describe 'Performance' do
    let(:file) { 'fixtures/small.json' }
    it 'reports' do
      user_time = Benchmark.realtime do
        task
      end
      puts "finished  in #{user_time}"
      #
      # StackProf.run(mode: :wall, out: 'reports/stackprof/cpu/sp.dump', interval: 1200) do
      #   task
      # end
      #
      # RubyProf.measure_mode = RubyProf::WALL_TIME
      # result = RubyProf.profile do
      #   task
      # end
      #
      # printer = RubyProf::CallTreePrinter.new(result)
      # printer2 = RubyProf::GraphHtmlPrinter.new(result)
      # printer3 = RubyProf::FlatPrinter.new(result)
      #
      # printer.print(path: 'reports/ruby_prof/cpu', profile: 'callgrid')
      # printer2.print(File.open('reports/ruby_prof/cpu/graph.html', 'w+'))
      # printer3.print($stdout)
    end
  end
end
