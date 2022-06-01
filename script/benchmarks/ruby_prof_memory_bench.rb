# https://ruby-prof.github.io/#version-1.0 (ruby 2.4+)
# ruby-prof + QCachegrind MEMORY profiling

require 'ruby-prof'
require_relative './benchmark_helper'

MODE = ENV['MODE']&.downcase

RubyProf.measure_mode = RubyProf::MEMORY

# system('rm ruby_prof_reports/profile.callgrind.out.*')

result = RubyProf.profile { work }

case MODE
when 'graph'
  printer = RubyProf::GraphHtmlPrinter.new(result)
  printer.print(File.open('ruby_prof_reports/graph.html', 'w+'))

  system('open ruby_prof_reports/graph.html')
when 'callstack'
  printer = RubyProf::CallStackPrinter.new(result)
  printer.print(File.open('ruby_prof_reports/callstack.html', 'w+'))

  system('open ruby_prof_reports/callstack.html')
when 'callgrind'
  printer = RubyProf::CallTreePrinter.new(result)
  printer.print(path: 'ruby_prof_reports', profile: 'profile')

  system('qcachegrind $(ls -Art ruby_prof_reports/profile.callgrind.out.* | tail -n1)')
else
  printer = RubyProf::FlatPrinter.new(result)
  printer.print(STDOUT, {})
end
