# frozen_string_literal: true

require 'ruby-prof'
require 'ruby-prof-speedscope'

task profile: :environment do |_task, _args|
  RubyProf.measure_mode = RubyProf::WALL_TIME

  GC.disable
  result = RubyProf.profile do
    ImportTrips.new('fixtures/example.json').call!
  end
  GC.enable

  prefix = 'lib/profilers/reports'

  RubyProf::FlatPrinter.new(result).print(File.open("#{prefix}/rubyprof_flat.txt", 'w+'))
  RubyProf::GraphHtmlPrinter.new(result).print(File.open("#{prefix}/rubyprof_graph.html", 'w+'))
  RubyProf::CallStackPrinter.new(result).print(File.open("#{prefix}/rubyprof_callstack.html", 'w+'))
  RubyProf::CallTreePrinter.new(result).print(path: prefix, profile: 'callgrind')
  # RubyProf::FlameGraphPrinter.new(result).print(File.open("#{prefix}/rubyprof_flamegraph.txt", 'w+'), {})
end
