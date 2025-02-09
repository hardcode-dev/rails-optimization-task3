# frozen_string_literal: true

require 'memory_profiler'
require 'stackprof'
require 'ruby-prof'


class Profiler
  REPORTS_DIR = 'reports'
  
  class << self
    def make_report(reporter_type)
      send(reporter_type)
    end

    def memeory_prof
      report = MemoryProfiler.report do
       system "bin/rake utils:reload_json[fixtures/medium.json]"
      end
      report.pretty_print(scale_bytes: true)
    end

    def stack_prof
      StackProf.run(mode: :object, out: "#{REPORTS_DIR}/stackprof.dump", raw: true) do
        system "bin/rake utils:reload_json[fixtures/medium.json]"
      end
    end

    def ruby_prof
      RubyProf.measure_mode = RubyProf::MEMORY
      result = RubyProf.profile do
        system "bin/rake utils:reload_json[fixtures/medium.json]"
      end
      printer = RubyProf::CallTreePrinter.new(result)
      printer.print(path: REPORTS_DIR, profile: 'profile')
    end
  end
end