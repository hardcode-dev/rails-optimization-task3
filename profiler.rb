# frozen_string_literal: true
require 'ruby-prof'
require_relative 'app/services/import_service'
require 'pry'

def collect_prof_wall
  RubyProf.measure_mode = RubyProf::WALL_TIME
  # GC.disable
  result = RubyProf.profile do
    ImportService.new('fixtures/medium.json').process
  end
  # GC.enable

  RubyProf::FlatPrinter.new(result).print(File.open('reports/flat_result', 'w+'))
  RubyProf::CallStackPrinter.new(result).print(File.open('reports/call_stack_result.html', 'w+'))
  RubyProf::GraphHtmlPrinter.new(result).print(File.open('reports/graph_result.html', 'w+'))
end

collect_prof_wall
