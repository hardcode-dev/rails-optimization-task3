# frozen_string_literal: true

require 'rake'
require 'ruby-prof'

REPORTS_DIR = 'lib/profilers/reports'

profile = RubyProf::Profile.new(measure_mode: RubyProf::WALL_TIME)

Rake.application.rake_require('tasks/utils')
Rake::Task.define_task(:environment)

result = profile.profile do
  Rake::Task['reload_json'].invoke('fixtures/small.json')
end

printer = RubyProf::CallTreePrinter.new(result)
printer.print(path: REPORTS_DIR, profile: "callgrind")
puts "Callgrind report generated at #{REPORTS_DIR}/callgrind.out"
