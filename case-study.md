#### Setup
в начале когда я разворачивал проект
я столкнулся с проблемами гема `mimemagic`
помогло
```bash
HOMEBREW_NO_AUTO_UPDATE=1 brew install shared-mime-info
bundle update mimemagic
```
дальше я решил развернуть постгрес и pghero но все через docker
```yaml
version: "3"
services:
  db:
    image: postgres:14.0-alpine
    ports:
      - 5432:5432
    volumes:
      - ./tmp/postgres_data:/var/lib/postgresql/data
      - ./docker/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d
    environment:
      - POSTGRES_PASSWORD=password
  pghero:
    image: ankane/pghero
    ports:
      - 8080:8080
    depends_on:
      - db
    environment:
      - DATABASE_URL=postgres://postgres:password@db:5432/task_3_development
```

затем вынес логику таски в сервис для удобства и добавил Benchmark
```ruby
task :reload_json, [:file_name] => :environment do |_task, args|
  Rails.logger = Logger.new(STDOUT)
  puts '----'
  puts Benchmark.realtime { JsonReloader.new(args.file_name).call }
end
```
- small.json импортится за 92.490
- medium.json 880.888
т.е примерно линейная зависимость
(не учел что вывод в STDOUT занимает много времени)

выбрал метрику для оптимизации - время импорта
буду оптимизироваться на ограниченном датасете
и постепенно увеличивать объем данных по мере оптимизации

далле я добавил feedback_loop для импорта

```ruby
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
```

по репортам rubyprof было сложно что-то понять
генерятся огромные репорты (в репортах отображается несколько тредов)
callgrind - генерит для каждого треда свой репорт

а вот в stackprof вывод достатачно локаничный
```bash
      1772  (42.5%)        1625  (39.0%)     ActiveRecord::ConnectionAdapters::PostgreSQLAdapter#exec_no_cache
      1414  (33.9%)        1307  (31.3%)     ActiveRecord::ConnectionAdapters::PostgreSQLAdapter#exec_cache
      102   (2.4%)         101   (2.4%)     ActiveRecord::ConnectionAdapters::PostgreSQL::DatabaseStatements#query
```

еще я посмотрел и flamegraph
всюды были методы с namespace - Activerecord
