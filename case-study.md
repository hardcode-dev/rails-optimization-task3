## Описание проблемы

Существующее web-приложение для поиска автобусных маршрутов между городами. Приложение использует фреймворк `Rails 5.2.3`, язык `ruby 2.6.3` (со стандартным интерпретатором) и СУБД `PostgreSQL 11.7`. 

При развёртывании приложения используется rake задача, выполняющая чтение данных из `json` файла, их обработку и запись в соответствующие таблицы базы данных. С ростом объёма данных наблюдается рост времени работы данной задачи до недопустимых значений (для файла `medium.json` на `10_000` ключей -- 9 с половиной минут). Для файла `large.json` (на `100_000` ключей) окончания работы дождаться не получилось (впрочем, не сильно и усердствовал).

Поставлена задача ограничить время импорта данных из файла `large.json` (`100_000` ключей) до 1 минуты.

## Формирование метрики

Добиться стабильного выполнения `rake` задач в контексте тестов `rspec` не удалось -- насколько я понял, из-за разнящихся окружений оболочки и тестов `rspec`. Нахрапом (добавляя соответствующие переменные окружения) решить проблему не получилось, потому перенёс функционал импорта данных в отдельный сервис-класс, принимающий имя `json` файла с данными. Написал тест на значение времени импорта данных с помощью вызова данного сервис-класса, не превышающее 1 минуту.

## Гарантия корректности работы оптимизированной программы

Т.к. тест в комплекте с программой не шёл, включил дополнительный тест на сравнение состава импортированных данных для файла на `1_000` ключей.

## Построение feedback-loop

После каждого внесения изменений, проверял время импорта данных с помощью вышеописанного теста для файла на `10_000` ключей. Также проверял соответствие импортированных сервис-классом данных тем, что были импортированы изначальным методом.

## Итерация №1

Прочитав описание гема `activerecord_import`, решил использовать его для импорта данных -- отдельными инсёртами в каждую конкретную таблицу.

Импорт в таблицы решил делать исключительно с помощью массива массивов -- т.к. этот способ указан как самый производительный. Для корректного наполнения массивов маршрутов и автобусо-услуг значениями `id` связанных с ними городов, услуг и автобусов сделал предварительную итерацию с формированием данных для этих трёх (городов, услуг и автобусов) сущностей. После этого произвёл импорт данных для них с последующей записью необходимых полей записанных данных в локальные хэши (для того, чтобы работать с ними, а не с БД). С помощью ещё одной итерации по данным сформировал массивы для маршрутов и автобусо-услуг. Для импорта данных последней сущности немного изменил структуру моделей `ActiveRecord` -- добавил модель `BusesService` и заменил `has_and_belongs_to_many` ассоциацию в модели Bus на стандартную связку из двух `has_many`. 

Ввиду нестабильной работы валидаций на уникальность, проводил её подобие до импорта данных с помощью стандартных методов `ruby`.

Использовал для чтения `json` файла библиотеку `oj`.

## Результаты

Импорт данных для файла на `10_000` ключей занял 17.4 секунд, импорт файла на `100_000` ключей -- 137 секунд.

В виду того, что импорт данных в таблицы производился самым эффективным методом (массивом массивов), счёл, что предел оптимизации на данной машине при полном, "непотоковом" чтении файла достигнут. Думал избавиться от предварительной итерации, но тогда пришлось бы производить импорт не массивами массивов, а хэшами или relation'ами, что на мой субъективный взгляд не может быть быстрее записи однородных массивов строк даже с учётом дополнительной итерации.

На рабочем ноутбуке импорт файла на `100_000` ключей занял `36` секунд. Импорт файла с `1_000_000` записей на нём же занял чуть больше 6 минут -- из чего я сделал вывод, что зависимость времени выполнения программы от объёма входных данных близка к линейной.

## Итерация №2

Для профилирования времени загрузки страницы (с данными, импортированными из файла `1M.json`) использовал следующие `rack-mini-profiler` и `bullet`.

`Rack-mini-profiler` показал время загрузки страницы в 2840 мс (исключая первую загрузку страницы после запуска веб-сервера, время её загрузки -- 4100 мс). Главная точка роста: рендеринг вью `trips/index` длительностью 2109 мс, включая 1388 мс, затраченных на 60 `sql` запросов.

`Rails panel` вёл себя нестабильно -- время загрузки страницы после его подключения выросло до 4500-5000 мс (прирост по показаниям `rack-mini-profiler` прирост приходился на рендеринг того же `trip/index`), сама вкладка в `Devtools`, то появлялась, то пропадала. Если всё же была, то переключение между её подвкладками не работало не всегда. В общем, удалил.

Добавил в проект `bullet` -- с выводом сообщений в лог веб-сервера. Время загрузки страницы выросло до 10 с. Сообщение в логе от `bullet` одно-единственное:

```
USE eager loading detected
  Trip => [:bus]
  Add to your query: .includes([:bus])
Call stack
  /media/share/extraspace/TN/repositories/rails-optimization-task3/app/views/trips/_trip.html.erb:5:in `_app_views_trips__trip_html_erb__1881149496845494434_47100636196060'
  /media/share/extraspace/TN/repositories/rails-optimization-task3/app/views/trips/index.html.erb:10:in `block in _app_views_trips_index_html_erb___2442525214590963597_47100638828440'
  /media/share/extraspace/TN/repositories/rails-optimization-task3/app/views/trips/index.html.erb:8:in `_app_views_trips_index_html_erb___2442525214590963597_47100638828440'
```

Добавил в `TripsController#index` `eager_load(bus: :services)` для коллекции trips (использовал `eager_load`, т.к. в дальнейшем данные из этих таблиц понадобятся при рендеринге). Заменил в вью `trips/index` подсчёт кол-ва маршрутов на `size`, проверку наличия услуг -- с помощью сравнения `length`, выполненного на коллекции услуг, с нулём (т.к. все данные уже находятся в памяти). Добавил индексы там, где выполняется `where` -- составной на полях `from_id` и `to_id` у таблицы `trips` и на поле `name` у таблицы `cities`.

Результаты

Время загрузки страницы (на объёме данных, импортированных из `1М.json`):

- при первом (после запуска веб-сервера) запросе 1.7 с;
- при последующих -- 0.6 с.

В чём тут дело? Где-то происходит кэширование? Не смог понять. Загрузил после повторных запросов к `Самара/Москва` страницу `Сочи/Москва` -- те же 600 мс.

Вот выхлоп первых строк `rack-mini-profiler` для первого запроса и для последующих. Количество `sql` запросов разное по каждой из строк.

```
GET http://2128506.net:9999/%D0%B0%D0%B2%D1%8...	173.5	+0.0	11 sql	31.7
  Executing action: index				89.9	+170.0	7 sql	19.9
   Rendering: trips/index				499.0	+259.0	7 sql	65.9
```

```
GET http://2128506.net:9999/%D0%B0%D0%B2%D1%8...	17.4	+0.0	1 sql	1.0
  Executing action: index				21.7	+14.0	2 sql	2.1
   Rendering: trips/index				269.2	+35.0	2 sql	43.0
```

Вот логи веб-сервера в части запросов к БД и общего времени обработки запроса (внизу), сначала для первого запроса:

```
   (4.1ms)  SELECT "schema_migrations"."version" FROM "schema_migrations" ORDER BY "schema_migrations"."version" ASC
  ↳ /home/mediaboxuser/.rbenv/versions/2.6.3/gemsets/rails-optimization-tasks-gemset/gems/rack-mini-profiler-1.1.6/lib/mini_profiler/profiler.rb:296
Processing by TripsController#index as HTML
  Parameters: {"from"=>"Самара", "to"=>"Москва"}
  City Load (3.2ms)  SELECT  "cities".* FROM "cities" WHERE "cities"."name" = $1 LIMIT $2  [["name", "Самара"], ["LIMIT", 1]]
  ↳ app/controllers/trips_controller.rb:3
  City Load (2.6ms)  SELECT  "cities".* FROM "cities" WHERE "cities"."name" = $1 LIMIT $2  [["name", "Москва"], ["LIMIT", 1]]
  ↳ app/controllers/trips_controller.rb:4
  Rendering trips/index.html.erb within layouts/application
   (22.4ms)  SELECT COUNT(DISTINCT "trips"."id") FROM "trips" LEFT OUTER JOIN "buses" ON "buses"."id" = "trips"."bus_id" LEFT OUTER JOIN "buses_services" ON "buses_services"."bus_id" = "buses"."id" LEFT OUTER JOIN "services" ON "services"."id" = "buses_services"."service_id" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2  [["from_id", 318], ["to_id", 309]]
  ↳ app/views/trips/index.html.erb:5
  SQL (29.8ms)  SELECT "trips"."id" AS t0_r0, "trips"."from_id" AS t0_r1, "trips"."to_id" AS t0_r2, "trips"."start_time" AS t0_r3, "trips"."duration_minutes" AS t0_r4, "trips"."price_cents" AS t0_r5, "trips"."bus_id" AS t0_r6, "buses"."id" AS t1_r0, "buses"."number" AS t1_r1, "buses"."model" AS t1_r2, "services"."id" AS t2_r0, "services"."name" AS t2_r1 FROM "trips" LEFT OUTER JOIN "buses" ON "buses"."id" = "trips"."bus_id" LEFT OUTER JOIN "buses_services" ON "buses_services"."bus_id" = "buses"."id" LEFT OUTER JOIN "services" ON "services"."id" = "buses_services"."service_id" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2 ORDER BY "trips"."start_time" ASC  [["from_id", 318], ["to_id", 309]]
  ↳ app/views/trips/index.html.erb:8
  
...

Completed 200 OK in 1719ms (Views: 1537.9ms | ActiveRecord: 131.0ms)
```

и для последующих:

```
  City Load (2.5ms)  SELECT  "cities".* FROM "cities" WHERE "cities"."name" = $1 LIMIT $2  [["name", "Самара"], ["LIMIT", 1]]
  ↳ app/controllers/trips_controller.rb:3
  City Load (4.6ms)  SELECT  "cities".* FROM "cities" WHERE "cities"."name" = $1 LIMIT $2  [["name", "Москва"], ["LIMIT", 1]]
  ↳ app/controllers/trips_controller.rb:4
  Rendering trips/index.html.erb within layouts/application
   (22.7ms)  SELECT COUNT(DISTINCT "trips"."id") FROM "trips" LEFT OUTER JOIN "buses" ON "buses"."id" = "trips"."bus_id" LEFT OUTER JOIN "buses_services" ON "buses_services"."bus_id" = "buses"."id" LEFT OUTER JOIN "services" ON "services"."id" = "buses_services"."service_id" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2  [["from_id", 318], ["to_id", 309]]
  ↳ app/views/trips/index.html.erb:5
  SQL (27.5ms)  SELECT "trips"."id" AS t0_r0, "trips"."from_id" AS t0_r1, "trips"."to_id" AS t0_r2, "trips"."start_time" AS t0_r3, "trips"."duration_minutes" AS t0_r4, "trips"."price_cents" AS t0_r5, "trips"."bus_id" AS t0_r6, "buses"."id" AS t1_r0, "buses"."number" AS t1_r1, "buses"."model" AS t1_r2, "services"."id" AS t2_r0, "services"."name" AS t2_r1 FROM "trips" LEFT OUTER JOIN "buses" ON "buses"."id" = "trips"."bus_id" LEFT OUTER JOIN "buses_services" ON "buses_services"."bus_id" = "buses"."id" LEFT OUTER JOIN "services" ON "services"."id" = "buses_services"."service_id" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2 ORDER BY "trips"."start_time" ASC  [["from_id", 318], ["to_id", 309]]
  ↳ app/views/trips/index.html.erb:8
  
...

Completed 200 OK in 587ms (Views: 522.2ms | ActiveRecord: 57.3ms)
```

По логу веб-сервера различия заключаются в загрузке `schema_migrations` (занявшую 4 мс), остальные запросы одинаковые.

Изучил те "дополнительные" (при первой загрузке) запросы через `rack-mini-profiler`, помимо "обычных" там несколько (собственно, почти все остальные) следующего рода:

```
SELECT a.attname, format_type(a.atttypid, a.atttypmod),
       pg_get_expr(d.adbin, d.adrelid), a.attnotnull, a.atttypid, a.atttypmod,
       c.collname, col_description(a.attrelid, a.attnum) AS comment
FROM pg_attribute a
  LEFT JOIN pg_attrdef d ON a.attrelid = d.adrelid AND a.attnum = d.adnum
  LEFT JOIN pg_type t ON a.atttypid = t.oid
  LEFT JOIN pg_collation c ON a.attcollation = c.oid AND a.attcollation <> t.typcollation
WHERE a.attrelid = '"cities"'::regclass
  AND a.attnum > 0 AND NOT a.attisdropped
ORDER BY a.attnum
```

А также совершенно чудесный:

```
SELECT 1;
```

Можно получить краткие пояснения, что это? Системные действия СУБД при первом обращении? Интернет изучал, но гуглится плохо.
