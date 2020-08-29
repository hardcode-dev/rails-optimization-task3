class BenchmarkEvaluation
  def self.run(file_name, without_db_queries = false)
    puts "Start"
    time = Benchmark.realtime { ReloadJson.new.call(file_name, without_db_queries) }
    puts "Finish in #{time.round(2)}"
  end
end
