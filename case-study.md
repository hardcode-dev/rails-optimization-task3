#### Setup
в начале когда я разворачивал проект
я столкнулся с проблемами в геме `mimemagic`
нужно апдейтнуть
```bash
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
и убрал лишний код из основной таски

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

перед оптимизацией написал спеку

```ruby
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonReloader do
  subject { described_class.new(file_name) }
  let(:file_name) { 'fixtures/example.json' }
  let(:source) { JSON(File.read(file_name)) }
  let(:expected_cities) do
    source.flat_map { |item| item.slice('from', 'to').values }.uniq.sort
  end

  context 'SUCCESS cases' do
    before do
      subject.call
    end

    it 'creates cities' do
      expect(City.all.pluck(:name).sort).to eq(expected_cities)
    end

    it 'creates buses' do
      aggregate_failures do
        source.each do |item|
          bus = Bus.find_by(number: item.dig('bus', 'number'))
          expect(bus.model).to eq(item.dig('bus', 'model'))
          expect(bus.services.pluck(:name).sort).to eq(item.dig('bus', 'services').sort)
        end
      end
    end

    it 'creates trips' do
      aggregate_failures do
        source.each do |item|
          attrs = item.slice('start_time', 'duration_minutes', 'price_cents').symbolize_keys
          expect(Trip.find_by(**attrs)).to_not be_nil
        end
      end
    end
  end
end
```

### Оптимизация Импорта
#### уменьшить количество вызовов active_record
- репорты профилировщиков показали что куча вречени проводится
  в #exec_no_cache (который триггерится из ActiveRecord::Persistence#update)
  и #exec_cache (который триггерится из ActiveRecord::Querying#find_or_create_by)
  (увидел в flamegraph)
  
- было принято решения использовать bulk_insert (activerecord-import)
  чтобы убрать вызовы find_or_create_by и update
  
- до отимизации на 100 записях ~ 5s
- после ~ 0.5s

```ruby
  buses = {}
  cities = {}
  services = {}
  buses_services_records = []
  trip_records = []

  json.each do |trip|
    from = find_or_add_record!(key: trip['from'], result_hash: cities) { |id| Hash[id: id, name: trip['from']] }
    to = find_or_add_record!(key: trip['to'], result_hash: cities) { |id| Hash[id: id, name: trip['to']] }
    bus_key = "#{trip.dig('bus','number')}#{trip.dig('bus','model')}"
    bus = find_or_add_record!(key: bus_key, result_hash: buses) do |id|
      source = trip['bus']
      bus_record = {
        id: id,
        number: source['number'],
        model: source['model']
      }

      source['services'].each do |service|
        service = find_or_add_record!(key: service, result_hash: services) { |id| Hash[id: id, name: service] }
        buses_services_records << [bus_record[:id], service[:id]]
      end

      bus_record
    end

    trip_record = {
      from_id: from[:id],
      to_id: to[:id],
      bus_id: bus[:id],
      start_time: trip['start_time'],
      duration_minutes: trip['duration_minutes'],
      price_cents: trip['price_cents']
    }

    trip_records << trip_record
  end

  Service.import services.values
  Bus.import buses.values

  ActiveRecord::Base.connection.execute(<<~SQL)
    INSERT INTO buses_services (bus_id, service_id) VALUES
    #{buses_services_records.map { |bus_id, service_id| "(#{bus_id},#{service_id})" }.join(', ')}
  SQL

  City.import cities.values
  Trip.import trip_records
end
# ...

def find_or_add_record!(key:, result_hash:)
  record = result_hash[key]
  return record if record
    
  id = result_hash.size + 1
  result_hash[key] = yield(id)
end
```

увеличил датасет в 10 раз время поднялось до ~ 0.8s (1000)
10_000 ~ 2.7s
100_000 ~ 19s

в целом импорт укладывается в заданный бюджет

отчеты stackprof сильно изменились
```bash
1.48s    (16%)	 ActiveRecord::ConnectionAdapters::PostgreSQLAdapter#exec_no_cache
921.84ms (10.0%) ActiveSupport::Callbacks::CallTemplate#expand
821.76ms (8.9%)	 ActiveModel::AttributeSet#[]
```
(последние два метода триггерятся валидациями)
без валидаций
100_000 - 8s (2.5x быстрее)



 чтобы защить достигнутый прогресс от деградации
 расширил спеку
```ruby
  context 'performance' do
	let(:file_name) { 'fixtures/medium.json' }
	let(:tables_count) { 5 }

    it "doesn't send unnecessary requests to db" do
      expect { subject.call }.not_to exceed_query_limit(15)
    end

	it 'does only bulk insert' do
      expect { subject.call }.not_to exceed_query_limit(tables_count).with(/^INSERT/)
    end

	it 'works fast' do
      expect { subject.call }.to perform_under(3).sec
    end
  end
```

### ОПТИМИЗАЦИЯ загрузки страницы

Перед оптимизациями добавил прстой классс
чтобы защититься от изменений в html

```ruby
# frozen_string_literal: true
require 'diffy'
require 'addressable'

class PageChangesChecker
  DEFAULT_PAGE = '/автобусы/Самара/Москва'
  LATEST_PAGE_FILE_NAME = 'tmp/latest_page.html'

  attr_reader :page, :app

  def initialize(page: DEFAULT_PAGE)
    @page = page
    @app = ActionDispatch::Integration::Session.new(Rails.application)
  end

  def dump_page
    app.get url
    File.write(LATEST_PAGE_FILE_NAME, clean_up_html(app.response.body))
  end

  def check_page
    elapsed_time = Benchmark.realtime { app.get url }
    latest_page = File.read(LATEST_PAGE_FILE_NAME)
    new_page = clean_up_html(app.response.body)

    puts Diffy::Diff.new(latest_page, new_page).to_s(:html)
    puts '====================='
    puts "TIME: #{elapsed_time}"
  end

  private

  def url
    @url ||= Addressable::URI.parse("http://localhost:3000/#{page}").display_uri.to_s
  end

  def clean_up_html(html)
    doc = Nokogiri::HTML(html)
    doc.xpath("//script").remove
    doc.to_s
  end
end
```

сейчас страница грузится ~ 37s

#### unnecessary partials rendering 
с помощью минипрофайлера и rails panel я обноружил кучу вызовов render
также bullet подсветил n+1 (к этому вернусь позже)

в flamegraph обноружил что значительное время тратилось в методе `find_template_paths`
решил переисать вьюху c использованием render collection

```ruby
<%= render partial: 'trip', collection: @trips, as: :trip %>
```
время загрузки уменьшилось до 17s

#### N+1
благодоря буллету добавил `.prelaod(bus: :services)`
время загрузки уменьшилось до 6s

#### unnecessary partials rendering
в консоли и в flamegraph видно что онсновное время все еще уходит на рендеринг
я убрал partial :service

в итоге текущее время ~ 3s
(в отчете видно что много времени уходит на буллет)
(когда выключил буллет время стало 1.6s)
(c включенным кэшом < 0.5s)

но рендеринг все еще главная точка роста
ActionView::PartialRenderer#render_collection ~ 40%

Но на этом я остановлюсь :)

### Выводы
мне очень понравился гем pg_hero
удобно смотреть стату запросов, и классно что гем дает советы каких индексов не хватает и тд
также минипрофайлер оказался очень удбным а rails pannel классно иользовать для повседневных дел
