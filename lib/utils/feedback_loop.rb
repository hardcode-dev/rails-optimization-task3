# frozen_string_literal: true
require 'fileutils'

# NOTE: use in development mode
module FeedbackLoop
  TEST_DATA_FILE_NAME = 'tmp/test.json'

  module_function

  def rubyprof_profiler
    GC.disable
    FileUtils.mkdir_p 'tmp/reports/rubyprof'

    RubyProf.measure_mode = RubyProf::WALL_TIME
    result = RubyProf.profile { yield }

    RubyProf::FlatPrinter.new(result).print($stdout)
    RubyProf::DotPrinter.new(result).print(File.open('tmp/reports/rubyprof/graphviz.dot', 'w+'))
    # open tmp/reports/rubyprof/graph.html
    RubyProf::GraphHtmlPrinter.new(result).print(File.open('tmp/reports/rubyprof/graph.html', 'w+'))
    # open tmp/reports/rubyprof/callstack.html
    RubyProf::CallStackPrinter.new(result).print(File.open('tmp/reports/rubyprof/callstack.html', 'w+'))
    # qcachegrind tmp/reports/rubyprof/profile.
    RubyProf::CallTreePrinter.new(result).print(path: 'tmp/reports/rubyprof', profile: 'profile')
  end

  def stackprof_profiler
    GC.disable
    FileUtils.mkdir_p 'tmp/reports/stackprof'

    # stackprof tmp/reports/stackprof/stackprof.dump -m #method_name
    StackProf.run(mode: :wall, out: 'tmp/reports/stackprof/stackprof.dump', raw: true) { yield }
  end

  def stackprof_profiler_flamegraph
    GC.disable
    profile = StackProf.run(mode: :wall, raw: true, interval: 1000) { yield }
    File.write('./tmp/reports/stackprof/speedscope.json', JSON.generate(profile))
  end

  def prepare_test_json(size)
    test_data = JSON(File.read('fixtures/medium.json')).first(size)
    File.write(TEST_DATA_FILE_NAME, JSON(test_data))
    TEST_DATA_FILE_NAME
  end

end
