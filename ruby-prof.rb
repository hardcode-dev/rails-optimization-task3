# require 'ruby-prof'
# require_relative 'seeds.rb'
#
# RubyProf.measure_mode = RubyProf::WALL_TIME
#
# result = RubyProf.profile do
#   work('fixtures/example.json')
# end
#
# printer = RubyProf::GraphHtmlPrinter.new(result)
# printer.print(File.open('graph.html', 'w+'))

#
# printer = RubyProf::FlatPrinter.new(result)
# printer.print(File.open('reports/flat.txt', 'w+'))
#
# printer = RubyProf::CallStackPrinter.new(result)
# printer.print(File.open('reports/call_stack.html', 'w+'))