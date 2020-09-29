require 'ruby-prof'
require 'benchmark'

namespace :profiling do
  desc 'ruby-prof'
  task ruby_prof: :environment do
    RubyProf.measure_mode = RubyProf::WALL_TIME

    GC.disable

    result = RubyProf.profile do
      file_path = Rails.root.join('fixtures', 'example.json')
      service = TripsReloadService.new(file_path)
      service.run
    end

    dir = Rails.root.join('tmp', 'ruby_prof')
    FileUtils.remove_dir(dir, true)
    mkdir_p(dir) unless File.exist?(dir)

    printer = RubyProf::FlatPrinter.new(result)
    printer.print(File.open(Rails.root.join('tmp', 'ruby_prof', 'flat.txt'), 'w+'))

    printer = RubyProf::GraphHtmlPrinter.new(result)
    printer.print(File.open(Rails.root.join('tmp', 'ruby_prof', 'graph.html'), 'w+'))

    printer = RubyProf::CallStackPrinter.new(result)
    printer.print(File.open(Rails.root.join('tmp', 'ruby_prof', 'callstack.html'), 'w+'))

    printer = RubyProf::CallTreePrinter.new(result)
    printer.print(path: Rails.root.join('tmp', 'ruby_prof'), profile: 'callgrind')
  end

  desc 'benchmark'
  task benchmark: :environment do
    Benchmark.bm do |x|
      %w[small.json medium.json large.json].each do |file|
        x.report(file) do
          file_path = Rails.root.join('fixtures', file)
          service = TripsReloadService.new(file_path)
          service.run
        end
      end
    end
  end
end
