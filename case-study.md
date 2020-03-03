# Case-study оптимизации

## Актуальная проблема
Дано веб-приложение для поиска рейсовых междугородних автобусов. В нем есть две основные проблемы.
1. Для наполнения базы данными по рейсам используется рейк-таска, которая импортрует информацию о маршрутах из
json файла. Операция импорта на больших файлах занимает слишком много времени. Необходимо снизить время этой операции.
2. Необходимо оптимизировать рендер страницы со списком маршрутов. Сейчас она загружается слишком долго.

## Формирование метрики
В обоих проблема ключевой метрикой является время работы. Для поставленых задач определим для себя такие бюджеты:
1. Загрузка файла со 100_000 рейсов (large.json) в пределах 1 минуты.
<!-- 2. Рендер рейсов загруженых из `example.json` в пределах 100 мс. -->

## Гарантия корректности работы оптимизированной программы
Перед тем, как дербанить программу, напишем простой тест, чтобы убедиться, что выдача ручки с индексом рейсов
не изменилась.
```
describe 'reload json task' do
  ...
  it 'creates all instances' do
    expect(City.count).to eq 2
    expect(Service.count).to eq 2
    expect(Bus.count).to eq 1
    expect(Trip.count).to eq 10
  end

  it 'creates correct instances' do
    bus_attrs.each do |k, v|
      expect(Bus.first.attributes[k]).to eq v
    end
    expect((Service.pluck(:name) & service_names).size).to eq 2
    expect((City.pluck(:name) & city_names).size).to eq 2
    first_trip_attrs.each do |k, v|
      expect(Trip.first.attributes[k]).to eq v
    end
  end
end
```

# Проблема 1
## Feedback loop
Для эффективного фидбек лупа напишем бенчмарк тест импорта данных.
```
describe 'large data import' do
  it 'works under 1 minute' do
    expect do
      `rake "reload_json[fixtures/large.json]"`
    end.to perform_under(60).sec
  end
end
```

При первом прогоне он ожидаемо не проходит.

## Вникаем в детали системы, чтобы найти главные точки роста
### Итерация 1
Посмотрим на код таски импорта. Почти вся работа происходит в итерации по трипам.
Попробуем включить ActiveRecord логгер и записать вывод в файл.
```ruby
ActiveRecord::Base.logger = Logger.new(STDOUT)
```

```
$ touch asdf
$ bundle exec rake 'reload_json[fixtures/small.json]' > asdf
```

Посчитаем количество инсертов и селектов, которые делаются скриптом при импорте `small.json` (1000 трипов).
```
$ grep INSERT asdf | wc -l
4265
$ grep SELECT asdf | wc -l
9239
```

Проделаем то же самое с файлом `medium.json` (10_000 трипов).
```
$ grep INSERT asdf | wc -l
15705
$ grep SELECT asdf | wc -l
96639
```

Как видим, количество инсертов и селектов огромно, и растет вместе с количеством трипов. И хотя каждый
запрос достаточно быстр, в основном это считаные миллисекунды, все же огромное количество запросов
сильно замедляет импорт. Воспользуемся библиотечкой `activerecord-import`, чтобы драматически сократить
количество обращений в базу.

Activerecord-import умеет возвращать информацию о количестве инсертов - сразу спросим его, скольо инсертов он
сделал на те же инпуты, что в примерах выше.
```
$ bundle exec rake 'reload_json[fixtures/small.json]'
5
$ bundle exec rake 'reload_json[fixtures/medium.json]'
5
```

Чудно! количество инсертов не растет с инпутом.
Наш тест на корректность зеленый, поэтому попробуем тест на время импорта большого файла.
```
$ bundle exec rspec spec/tasks/reload_json_performance_spec.rb
.

Finished in 34.96 seconds (files took 0.51447 seconds to load)
  1 example, 0 failures
```
Отлично! Импорт проходит за 35 секунд. Если попробовать утилиту `time`, то она покажет еще более
оптимистичный результат:
```
$ time bundle exec rake 'reload_json[fixtures/large.json]'
bundle exec rake 'reload_json[fixtures/large.json]'  17.34s user 0.24s system 94% cpu 18.621 total
```

Воспользуемся в таске полезной фичей гема и сразу добавим вывод варнингов если есть зафейленые инсерты:
```
fails = []
...
fails += Service.import(services).failed_instances
fails += City.import(cities.to_a).failed_instances
fails += Bus.import(buses.to_a).failed_instances
...
if fails.any?
  puts "Failed instances: #{fails}"
else
  puts 'Everything is fine.'
end
```
И перейдем ко второй проблеме.

# Проблема 2
## Feedback loop

## Вникаем в детали системы, чтобы найти главные точки роста

### Итерация 1

### Итерация 2

# Результаты
В результате проделанной оптимизации удалось...

# Защита от регрессии производительности
Для защиты от потери достигнутого прогресса при дальнейших изменениях программы...
