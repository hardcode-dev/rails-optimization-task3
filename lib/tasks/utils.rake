require 'benchmark/ips'

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  Benchmark.ips do |x|
    x.config(:stats => :bootstrap, :confidence => 95)
    x.report do
      ReloadJson.new(args.file_name).call
    end
  end
end
