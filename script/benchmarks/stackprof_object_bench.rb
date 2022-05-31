
# Stackprof ObjectAllocations and Flamegraph
#
# Text:
# stackprof stackprof.dump
# stackprof stackprof.dump --method JSONImporter#call
#
# Graphviz:
# stackprof --graphviz stackprof_reports/stackprof.dump > graphviz.dot
# dot -Tpng graphviz.dot > graphviz.png
# imgcat graphviz.png
#
# Flamegraph:
# stackprof --d3-flamegraph stackprof_reports/stackprof.dump > stackprof_reports/flamegraph.html


require 'stackprof'
require_relative './benchmark_helper'

MODE = ENV['MODE']&.downcase

# Note mode: :object
StackProf.run(mode: :object, out: 'stackprof_reports/stackprof.dump', raw: true) { work }

case MODE
when 'flamegraph'
  system("stackprof --d3-flamegraph stackprof_reports/stackprof.dump > stackprof_reports/flamegraph.html")
  system("open stackprof_reports/flamegraph.html")
else
  system("stackprof stackprof_reports/stackprof.dump --method JSONImporter#call")
end
