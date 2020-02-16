# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

require 'benchmark'

# It allow to measure metrics for each task
class Rake::Task
  def execute_with_benchmark(*args)
    bm = Benchmark.measure { execute_without_benchmark(*args) }
    puts "   #{name} --> #{bm}"
  end

  alias_method :execute_without_benchmark, :execute
  alias_method :execute, :execute_with_benchmark
end

Rails.application.load_tasks
