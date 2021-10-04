# frozen_string_literal: true

module Profilers
  class BigDataImporterProfiler
    FILE_NAME = '10M'.freeze

    def self.call
      time = Benchmark.realtime do
        BigDataImporter.call("fixtures/#{FILE_NAME}.json")
      end
      puts "Время выполнения: #{time.round(3)}"
    end
  end
end


