# frozen_string_literal: true

task :profile do
  require 'fileutils'
  require 'rake'
  require 'ruby-prof'
  require 'memory_profiler'

  REPORTS_DIR = 'lib/profilers/reports'

  report = MemoryProfiler.report do
    Rake::Task['reload_json'].invoke('fixtures/small.json')
  end

  report.pretty_print(scale_bytes: true)
  # profile = RubyProf::Profile.new(measure_mode: RubyProf::WALL_TIME)

  # # Rake.application.rake_require('tasks/utils')
  # # Rake::Task.define_task(:environment)

  # result = profile.profile do
  #   Rake::Task['reload_json'].invoke('fixtures/small.json')
  # end

  # printer = RubyProf::FlatPrinter.new(result)
  # File.open("#{REPORTS_DIR}/flat.txt", 'w+') { |file| printer.print(file) }
  # puts "Flat profile report generated at #{REPORTS_DIR}/flat.txt"


end
