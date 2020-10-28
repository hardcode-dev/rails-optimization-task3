# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

describe 'reload_json_performance' do
  subject(:task) { Rake::Task['reload_json'].invoke(file) }
  describe 'Performance' do
    let(:file) { 'fixtures/small.json' }
    it 'reports' do
      RubyProf.measure_mode = RubyProf::ALLOCATIONS
      rb_result = RubyProf.profile do
        task
      end

      rb_printer = RubyProf::FlatPrinter.new(rb_result)
      rb_printer.print(File.open("reports/ruby_prof/memory/alloc_flat_#{Time.now.to_i}.txt", 'w+'))
      #
      # RubyProf.measure_mode = RubyProf::MEMORY
      # rb_result = RubyProf.profile do
      #   task
      # end

      # rb_printer = RubyProf::CallTreePrinter.new(rb_result)
      # rb_printer.print(path: 'reports/ruby_prof/memory', profile: 'profile')
      mp_report = MemoryProfiler.report do
        task
      end

      mp_report.pretty_print

      Benchmark.memory do |x|
        x.report('work') { task }
      end

      user_time = Benchmark.realtime do
        task
      end
      expect(user_time).to eq(0)
    end
  end
end
