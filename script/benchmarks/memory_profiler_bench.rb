
# memory_profiler (ruby 2.3.8+)
# allocated - total memory allocated during profiler run
# retained - survived after MemoryProfiler finished

require 'memory_profiler'
require_relative './benchmark_helper'

report = MemoryProfiler.report(allow_files: 'rails-optimization-task3') { work }

report.pretty_print(scale_bytes: true, to_file: 'memory_profiler_reports/report.txt')
system("cat memory_profiler_reports/report.txt")
