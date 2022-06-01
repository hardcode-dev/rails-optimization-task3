require 'stackprof'
require_relative './benchmark_helper'

MODE = ENV['MODE']&.downcase

# Stackprof report
# Text:
# stackprof stackprof.dump
# Stackprof report -> flamegraph in speedscope
# ruby 17-stackprof-speedscope.rb
case MODE
when 'speedscope'
  profile = StackProf.run(mode: :wall, raw: true) do
    with_gc_off { work }
  end
  File.write('stackprof_reports/stackprof.json', JSON.generate(profile))
  system('open ./stackprof_reports')
  system('open https://www.speedscope.app/')
else
  StackProf.run(mode: :wall, out: 'stackprof_reports/stackprof.dump', raw: true) do
    with_gc_off { work }
  end

  system("stackprof stackprof_reports/stackprof.dump --method JSONImporter#call")
end

# Graphviz:
# stackprof --graphviz stackprof_reports/stackprof.dump > graphviz.dot
# dot -Tpng graphviz.dot > graphviz.png
# imgcat graphviz.png


