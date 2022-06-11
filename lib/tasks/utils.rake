# frozen_string_literal: true
# rake reload_json[fixtures/small.json]
require_relative '../services/load_data'
require 'benchmark'

task :reload_json, [:file_name] => :environment do |_task, args|
  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    Benchmark.bm do |x|
      x.report('Clearing database') do
        ActiveRecord::Base.connection.execute(
          'TRUNCATE TABLE cities, buses, services, trips, buses_services;'
        )
      end

      x.report('Creating data') do
        LoadData.new(json).load
      end
    end
  end
end
