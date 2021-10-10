require 'ruby-prof'

task ruby_prof: :environment do
  RubyProf.measure_mode = RubyProf::WALL_TIME

  result = RubyProf.profile do
    Rake::Task[:reload_json].invoke('fixtures/small.json', true)
  end
  
  printer = RubyProf::FlatPrinter.new(result)
  printer.print(File.open("tmp/ruby_prof_reports/flat_#{Time.now.to_i}.txt", "w+"))
  
  printer_2 = RubyProf::GraphHtmlPrinter.new(result)
  printer_2.print(File.open("tmp/ruby_prof_reports/graph_#{Time.now.to_i}.html", "w+"))
  
  printer_3 = RubyProf::CallTreePrinter.new(result)
  printer_3.print(:path => "tmp/ruby_prof_reports", :profile => 'callgrind')

  printer_4 = RubyProf::CallStackPrinter.new(result)
  printer_4.print(File.open("tmp/ruby_prof_reports/callstack_#{Time.now.to_i}.html", 'w+'))
end

