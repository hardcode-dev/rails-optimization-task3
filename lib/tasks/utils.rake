# frozen_string_literal: true

require 'benchmark'

task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    ImportJSONService.perform(args.file_name)
  end
  puts "Finished in #{time.round(2)}s"
end
