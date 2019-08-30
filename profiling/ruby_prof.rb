# frozen_string_literal: true

puts 'Loading environment'
require_relative '../config/environment'
require 'populate_database'

# RubyProf.measure_mode = RubyProf::MEMORY
RubyProf.measure_mode = RubyProf::WALL_TIME

puts 'Profiling...'
result = RubyProf.profile do
  PopulateDatabase.call(file_path: 'fixtures/small.json')
end

puts 'Print results to file'
printer = RubyProf::FlatPrinter.new(result)
printer.print(File.open("profiling/flat.txt", 'w+'))
