# frozen_string_literal: true

require 'ruby-prof'
require 'fileutils'
require_relative '../../app/services/reloader'

REPORTS_DIR = 'tmp/profile_reports/ruby_prof_reports'

FileUtils.rm_rf(REPORTS_DIR)
FileUtils.mkdir_p(REPORTS_DIR)

profile = RubyProf::Profile.new(measure_mode: RubyProf::WALL_TIME)
result = profile.profile { Reloader.call("fixtures/large.json") }

RubyProf::FlatPrinter.new(result).print(File.open("#{REPORTS_DIR}/flat.txt", "w+"))
RubyProf::GraphHtmlPrinter.new(result).print(File.open("#{REPORTS_DIR}/graph.html", "w+"))
RubyProf::CallStackPrinter.new(result).print(File.open("#{REPORTS_DIR}/callstack.html", 'w+'))
RubyProf::CallTreePrinter.new(result).print(path: REPORTS_DIR, profile: 'callgrind')
