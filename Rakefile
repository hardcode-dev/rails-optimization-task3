# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

module Rake
  class Task
    def execute_with_timestamps(*args)
      start = Time.now
      execute_without_timestamps(*args)
      execution_time_in_seconds = Time.now - start
      printf("** %s took %.1f seconds\n", name, execution_time_in_seconds)
    end

    alias :execute_without_timestamps :execute
    alias :execute :execute_with_timestamps
  end
end

Rails.application.load_tasks
