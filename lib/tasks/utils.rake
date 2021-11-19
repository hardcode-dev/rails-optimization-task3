# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  Rails.logger = Logger.new($stdout)
  puts '----'
  puts Benchmark.realtime { JsonReloader.new(args.file_name).call }
end

TEST_DATA_SIZE = 100

namespace :feedback_loop do
	task benchmark_import: :environment do
	  # Rails.logger = Logger.new($stdout)
	  file_name = FeedbackLoop.prepare_test_json(TEST_DATA_SIZE)
	  puts Benchmark.realtime { JsonReloader.new(file_name).call }
	end

	task rubyprof_report: :environment do
		file_name = FeedbackLoop.prepare_test_json(TEST_DATA_SIZE)
		FeedbackLoop.rubyprof_profiler { JsonReloader.new(file_name).call }
	end

	task stackprof_report: :environment do
		file_name = FeedbackLoop.prepare_test_json(TEST_DATA_SIZE)
		FeedbackLoop.stackprof_profiler { JsonReloader.new(file_name).call }
	end

	task flameraph: :environment do
		file_name = FeedbackLoop.prepare_test_json(TEST_DATA_SIZE)
		FeedbackLoop.stackprof_profiler_flamegraph { JsonReloader.new(file_name).call }
	end
end
