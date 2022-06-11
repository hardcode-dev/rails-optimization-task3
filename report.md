#№ Оптимизация импорта данных
Установил `gem 'annotate'` для того, что бы увидеть зависимости, поля и индексы таблиц.
По аннотации моделей и файлу `schema.rb` увидел, что у таблиц нет индексов, ограничений и внешних ключей.
Заметил в partial `_trip.html.erb` парсинг даты `Time.parse(trip.start_time)`, возможная точка "просадки".
Устанавливаем gems `rack-mini-profiler`, `memory_profiler`, `stackprof`.

Из результатов `ruby-prof` видно, что больше всего занимают системные команды:
```bash
 %self      total      self      wait     child     calls  name                           location
100.00     17.335    17.335     0.000     0.000        6   Kernel#system
  0.00     17.335     0.000     0.000    17.335        1   <Class::Dir>#chdir
  0.00      0.000     0.000     0.000     0.000        5   IO#write
  0.00     16.936     0.000     0.000    16.936        5   Object#system!                 bin/setup:12
  0.00      0.000     0.000     0.000     0.000        5   Kernel#puts
  0.00     17.335     0.000     0.000    17.335        1   [global]#                      bin/setup:17
  0.00      0.000     0.000     0.000     0.000        5   IO#puts
  0.00     17.335     0.000     0.000    17.335        1   FileUtils#chdir
```

Из результатов `benchmark`, что больше всего занимает команда `bin/rake reload_json[fixtures/small.json]`:
```bash
Preparing database 0.000103   0.000508   1.093328 (  1.944473)
Loading data from fixtures/small.json  0.000135   0.000640   7.975272 (  9.584417)
Removing old logs and tempfiles  0.000086   0.000496   0.932335 (  1.058748)
Restarting application server  0.000090   0.000746   2.046295 (  2.378705)
```

Делаем замеры удаления и загрузки данных. Результаты `ruby-prof`:
```bash
== Loading data from fixtures/small.json ==
       user     system      total        real
Clearing database  0.031440   0.015737   0.047177 (  0.059329)
Creating data  6.535195   0.460577   6.995772 (  8.405738)
```
Попробуем оптимизировать удаление данных единой, нативной командой.

Скорость очистки данных увеличилась в *два раза*. Результаты `ruby-prof` после оптимизации:
```bash
== Loading data from fixtures/small.json ==
       user     system      total        real
Clearing database  0.000310   0.000062   0.000372 (  0.024704)
Creating data  7.501429   0.555087   8.056516 (  9.712722)
```

Делаем замеры очистки и загрузки `medium.json` файла:
```bash
== Loading data from fixtures/small.json ==
       user     system      total        real
Clearing database  0.000282   0.000058   0.000340 (  0.020484)
Creating data 52.427992   4.816776  57.244768 ( 74.925987)
```

- Ускоряем загрузку с файла используя `gem 'activerecord-import'`.
- Рекурсивная загрузка данных при помощи `gem 'activerecord-import'` не работает.
- Добавляем вторичные ключи на таблицы. Для того что бы обезопасить себя от проблем
в новых миграциях устанавливаем `gem 'strong_migrations'`

`strong_migrations` предложил проверять вторичные ключи после их применения. В связи с возможной блокировкой таблицы:
```
=== Dangerous operation detected #strong_migrations ===

Adding a foreign key blocks writes on both tables. Instead,
add the foreign key without validating existing rows,
then validate them in a separate migration.
```

Было принято сформировать массивы данных для одноразового запроса на сохранения для каждой таблицы:

- buses
- buses_services
- cities
- services
- trips

Было принято решения для формирования запроса с помощью `'activerecord-import'`
к таблице `buses_service` добавить модель *BusesService*

Делаем замеры очистки и загрузки `medium.json` файла после оптимизации загрузки:
```bash
       user     system      total        real
Clearing database  0.000804   0.000062   0.000866 (  0.019000)
Creating data  3.490024   0.043684   3.533708 (  4.531744)
```

Скорость загрузки увеличилась более чем *x16* раз. Делаем замеры очистки и загрузки `large.json`:
```bash
       user     system      total        real
Clearing database  0.000229   0.000045   0.000274 (  0.017986)
Creating data 35.507971   0.369157  35.877128 ( 44.157531)
```

Из результатов видно, что мы достигли желаемого результата в бюджет в одну минуту.

#3 Страница автобусы/Самара/Москва

- `rack-mini-profiler` показал `1318.0 ms`. Результаты показали большое количество запросов при rendering маршрутов:
```bash
GET http://localhost:3000/%D0%B0%D0%B2%D1%82%... 	2.9 	+0.0 	1 sql 	0.2
  Executing action: index 	11.6 	+2.0 	2 sql 	0.4
   Rendering: trips/index.html.erb 	1159.8 	+7.1 	100 sql 	763.6
    Rendering: trips/_trip.html.erb 	2.1 	+15.9 	1 sql 	0.2
    Rendering: trips/_services.html.erb 	23.0 	+67.7
    Rendering: trips/_services.html.erb 	3.1 	+105.4
     Rendering: trips/_service.html.erb 	9.1 	+105.8
...

client event 	duration (ms) 	from start (ms)
Response 	0.0 	+3607.0
Load Event 	5.0 	+3742.0 
```

- Проверяем результаты при помощи `rais panel extension for chrome`.
Устанавливаем для работы расширения `gem 'meta_request'`. Из результатов видно, что больше всего занимает rendering:

| Component	   | Execution time |
|--------------|----------------|
| ActiveRecord | 980 ms         |
| Rendering	   | 4,216 ms       |
| Other	       | 22 ms          |

- Для проверки возможных не оптимальных запросов воспользуемся `gem 'bullet'`.
Результаты запуска показали необходимость добавления `eager loading` для автобусов:

```
user: anymacstore
USE eager loading detected
  Trip => [:bus]
  Add to your query: .includes([:bus])
Call stack
  /.../rails-optimization-task3/app/views/trips/_trip.html.erb:5:in 
```

- Принято решение добавить `Trip.includes(bus: %i[services])` и упростить количество используемых partials.
- Повторные замеры `rack-mini-profiler` показали `1618.0 ms`. Результаты `rais panel` изменились в лучшую сторону:
| Component	   | Execution time |
|--------------|----------------|
| ActiveRecord | 275 ms         |
| Rendering	   | 1,223 ms       |
| Other	       | 29 ms          |

- Из анализа запросов `rack-mini-profiler` видно, что есть проблемы с индексами таблиц.
Для анализа проблем с индексами установим `gem 'pghero'` и `gem 'pg_query'`.
Обозримых проблем инструмент не дал.

- Из результатов  `rack-mini-profiler` стало понятно, что много времени тратится на выборку сервисов автобусов
через связную таблицу. Анализ свойств таблицы показал, что в таблице нет индекса.
Принято решение добавить составной индекс с проверкой уникальности на поля `bus_id` и `service_id`.
Результатом стало увеличение производительности с `1563.0 ms` до `787.0 ms`.

- Дальнейшее исследование запросов показало возможность увеличения скорости запроса выборки маршрутов по городам:
```bash
T+133.3 ms
SELECT COUNT(*) FROM "trips" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2; 

T+140.3 ms
SELECT "trips".* FROM "trips" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2 ORDER BY "trips"."start_time" ASC; 
```

Решением стало добавить составной индекс на поля `from_id` и `to_id`.
В результате скорость страницы выросла с `787.0 ms` до `400.7 ms`. Скорость работы запросов увеличилась:

```bash
T+10.6 ms
SELECT COUNT(*) FROM "trips" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2; 

T+12.8 ms
SELECT "trips".* FROM "trips" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2 ORDER BY "trips"."start_time" ASC; 
```

Интересно: В ходе оптимизации таблиц увеличилась производительность загрузки данных:
```bash
rake reload_json[fixtures/medium.json]
       user     system      total        real
Clearing database  0.000480   0.000066   0.000546 (  0.025864)
Creating data 16.826109   0.243749  17.069858 ( 22.072621)
```
