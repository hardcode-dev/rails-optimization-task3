# frozen_string_literal: true

module Profilers
  class DataImporterProfiler
    FILE_NAME = 'medium'.freeze

    def self.call
      time = Benchmark.realtime do
        DataImporter.call("fixtures/#{FILE_NAME}.json")
      end
      puts "Время выполнения: #{time.round(3)}"
    end
  end
end


