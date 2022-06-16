require 'ruby-prof'
require_relative '../app/services/json_importer.rb'

RubyProf.measure_mode = RubyProf::WALL_TIME

result = RubyProf.profile do
  JsonImporter.new.call(file_name: "fixtures/small.json")
end

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(File.open("profilers/ruby_prof_reports/graph.html", "w+"))
