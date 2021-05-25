# Проблема №1

Долгая работа импорта в рейк таске для записей в 100к

## Метрика:

Оптимизировать работу скрипта таким образом, что бы импорт в 100к записей вписывался в рамки 60секунд. Собственно бюджет по времени 1 минута

###План работы:

* написать спеку на рейк таску (по виду достаточно обычных каунтов в базе)
* написать перфоманс спеку
* обновить рельсу до 6 версии (чтоб не ставить гем activerecord-import), руби до 2.7.1 и pg до 13.1
* запустить бенчмарк на семплах
* следовать фреймворку оптимизации
* написать прогресс бар (принта хватит :) )

### Гпотеза №1

Начальный Бенчмарк small

```
Time: 9.89
Memory: 102.94 MB
```

В рейк-задаче происходит множественные запросы к БД, стоит сократить их количество:

* избавится от очистки базы с 5 запросов в 1 sql (думаю смысла в чистке базы нет в данном случае, но оставлю)
* избавиться от find_or_create_by и организовать хеш в памяти
* избавится от Trip.create! и сделать батч инсерт в базу
* Добавить класс BusesServices чтоб можно было импортировать бачами нормально (хорошо бы связь has_and_belongs_to_many переделать, но не буду т.к не это главное)

После оптимизации small:

```
Time: 1.82
Memory: 107.43 MB
```

После оптимизации large:

```
Time: 20.68
Memory: 499.95 MB
```

##Итог

метрика достигнута в первой итерации, ну и ладно война будет в hardcore)

# Проблема №2

Долгая загрузка страницы с расписаниями

##Метрика:

Загрузка страницы за наименьшее количество запросов к БД, < 10.


###План работы:

* написать спеку на отображение
* воспользоваться rack-mini-profiler
* rails panel
* bullet + Prosopite для большей точности определения n+1
* Pghero
* explain

## Гипотеза №1

При сборе метрик с bullet дал отчет

```
USE eager loading detected
  Trip => [:bus]
  Add to your query: .includes([:bus])
```

А Prosopite намекнул что там еще есть  `SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1` что говорит нам о том что мы нам стоит вместо предложенного `.includes` заиспользовать `.includes(bus: :services)` но я воспользуюсь `.eager_load(bus: :services)` для большей наглядности того как нужно собирать таблицу.

Также после оптимизации запросов, bullet еще предлагает сделать:
```USE eager loading detected
  Bus::HABTM_Services => [:buses_services]
  Add to your query: .includes([:buses_services])
```

Но у нас Trip пока никак не связан с сервисами в автобусах. Оставлю на подумать попозже, а пока воспользуюсь другими инструментами.

## Гипотеза №2

Воспользовался pghero для сбора статистики по запросам посмотреть возможные индексы6 которые мы опустили или возможные тяжелые запросы.

Первое предложение добавить индекс для поиска трипов

```
CREATE INDEX CONCURRENTLY ON trips (from_id, to_id)
```

Так же из несистемных sql запросах есть, запрос на каунт достаточно долгий

```
SELECT COUNT(DISTINCT "trips"."id") FROM "trips" LEFT OUTER JOIN "buses" ON "buses"."id" = "trips"."bus_id" LEFT OUTER JOIN "buses_services" ON "buses_services"."bus_id" = "buses"."id" LEFT OUTER JOIN "services" ON "services"."id" = "buses_services"."service_id" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2
```

Можно его обойти загрузив в пямять `.load.size` думаю что тут такая оптимизация может быть оправдана. Конечно в реальном проекте я бы уточнился у бизнеса на сколько эта метрика важна для них, и скорее всего не стал трогать)

Так же заметил что есть два запроса на поиск двух городов, в целом можно было бы объеденить в один, но делать не стал т.к на это никакие метрики не указывают что у нас тут есть просадка в производительности. Но в целом конечно это n+1 небольшой)

Есть еще будующие оптимизации, например добавление индекса на name в services и cities, или создание композитного ключа для buses_services (хоть оно и указано в подсказках я не заметил проблемы с этим), пока добавлять не стал т.к индексы место занимают а профита пока от этого нет.

### Гипотеза №3

bullet продолжает настаивать на оптимизации вида

```
USE eager loading detected
  Bus => [:buses_services]
  Add to your query: .includes([:buses_services])
```

Но судя по отчетам pghero у нас нет сотен вызовов этого запроса. По этому думаю лучше использовать Prosopite вместо bullet чтоб он ложные предположения не предлагал. Но возможно он ругается на неоптимальную загрузку вьюх

```
  Rendered trips/_trip.html.erb (Duration: 1.4ms | Allocations: 264)
  Rendered trips/_service.html.erb (Duration: 1.8ms | Allocations: 41)
  Rendered trips/_service.html.erb (Duration: 1.6ms | Allocations: 40)
  Rendered trips/_service.html.erb (Duration: 2.3ms | Allocations: 41)
  Rendered trips/_service.html.erb (Duration: 2.2ms | Allocations: 41)
  Rendered trips/_service.html.erb (Duration: 1.8ms | Allocations: 41)
  Rendered trips/_service.html.erb (Duration: 1.4ms | Allocations: 41)
  Rendered trips/_service.html.erb (Duration: 1.3ms | Allocations: 41)
  Rendered trips/_service.html.erb (Duration: 1.2ms | Allocations: 40)
  Rendered trips/_services.html.erb (Duration: 17.6ms | Allocations: 1342)
  Rendered trips/_delimiter.html.erb (Duration: 1.2ms | Allocations: 38)
  Rendered trips/_trip.html.erb (Duration: 1.9ms | Allocations: 264)
  Rendered trips/_delimiter.html.erb (Duration: 1.4ms | Allocations: 38)
  Rendered trips/index.html.erb within layouts/application (Duration: 9788.3ms | Allocations: 2633203)
```

Видно что с вьюхами явно что-то не так

Думаю что надо избавится от множественного вызова service и воспользоваться partial рендерингом коллекций	.
Не увидел большого профита от вызова partial _trip, решил объединитьвсе в одном месте, читаемость не особо испортилась
А так же стоитстоит избавиться , только лишний раз вызывает метод рендера, если нужнен разделитель то проще CSS заиспользовать.

```
  Rendered collection of trips/_service.html.erb [3 times] (Duration: 0.5ms | Allocations: 547)
  Rendered collection of trips/_service.html.erb [5 times] (Duration: 0.6ms | Allocations: 625)
  Rendered collection of trips/_service.html.erb [4 times] (Duration: 0.7ms | Allocations: 586)
  Rendered collection of trips/_service.html.erb [2 times] (Duration: 0.5ms | Allocations: 506)
  Rendered collection of trips/_service.html.erb [1 times] (Duration: 0.6ms | Allocations: 576)
  Rendered collection of trips/_service.html.erb [8 times] (Duration: 0.6ms | Allocations: 745)
  Rendered trips/index.html.erb within layouts/application (Duration: 2769.5ms | Allocations: 2637561)
```

Что с bullet не понятно, запросов этих я не вижу но варнинг выскакивает...

## Гипотеза №4

Решил воспользоваться explain analyze самого долгого запроса из бд

```
SELECT "trips"."id" AS t0_r0, "trips"."from_id" AS t0_r1, "trips"."to_id" AS t0_r2, "trips"."start_time" AS t0_r3, "trips"."duration_minutes" AS t0_r4, "trips"."price_cents" AS t0_r5, "trips"."bus_id" AS t0_r6, "buses"."id" AS t1_r0, "buses"."number" AS t1_r1, "buses"."model" AS t1_r2, "services"."id" AS t2_r0, "services"."name" AS t2_r1 FROM "trips" LEFT OUTER JOIN "buses" ON "buses"."id" = "trips"."bus_id" LEFT OUTER JOIN "buses_services" ON "buses_services"."bus_id" = "buses"."id" LEFT OUTER JOIN "services" ON "services"."id" = "buses_services"."service_id" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2 ORDER BY "trips"."start_time" ASC
```

```
Sort  (cost=1479.03..1490.09 rows=4425 width=96) (actual time=31.036..31.741 rows=4703 loops=1)
  Sort Key: trips.start_time
  Sort Method: quicksort  Memory: 1131kB
  ->  Hash Left Join  (cost=1037.94..1211.06 rows=4425 width=96) (actual time=2.690..8.266 rows=4703 loops=1)
        Hash Cond: (buses_services.service_id = services.id)
        ->  Hash Right Join  (cost=1036.71..1193.31 rows=4425 width=61) (actual time=2.653..6.235 rows=4703 loops=1)
              Hash Cond: (buses_services.bus_id = buses.id)
              ->  Seq Scan on buses_services  (cost=0.00..95.34 rows=4534 width=8) (actual time=0.022..0.617 rows=4534 loops=1)
              ->  Hash  (cost=1024.51..1024.51 rows=976 width=57) (actual time=2.620..2.624 rows=1004 loops=1)
                    Buckets: 1024  Batches: 1  Memory Usage: 102kB
                    ->  Hash Left Join  (cost=51.80..1024.51 rows=976 width=57) (actual time=0.610..2.001 rows=1004 loops=1)
                          Hash Cond: (trips.bus_id = buses.id)
                          ->  Bitmap Heap Scan on trips  (cost=14.30..984.44 rows=976 width=34) (actual time=0.256..1.026 rows=1004 loops=1)
                                Recheck Cond: ((from_id = 124) AND (to_id = 122))
                                Heap Blocks: exact=577
                                ->  Bitmap Index Scan on index_trips_on_from_id_and_to_id  (cost=0.00..14.05 rows=976 width=0) (actual time=0.169..0.170 rows=1004 loops=1)
                                      Index Cond: ((from_id = 124) AND (to_id = 122))
                          ->  Hash  (cost=25.00..25.00 rows=1000 width=23) (actual time=0.342..0.343 rows=1000 loops=1)
                                Buckets: 1024  Batches: 1  Memory Usage: 63kB
                                ->  Seq Scan on buses  (cost=0.00..25.00 rows=1000 width=23) (actual time=0.005..0.121 rows=1000 loops=1)
        ->  Hash  (cost=1.10..1.10 rows=10 width=39) (actual time=0.012..0.012 rows=10 loops=1)
              Buckets: 1024  Batches: 1  Memory Usage: 9kB
              ->  Seq Scan on services  (cost=0.00..1.10 rows=10 width=39) (actual time=0.006..0.008 rows=10 loops=1)
Planning Time: 0.467 ms
Execution Time: 32.161 ms
```

Судя по отчету проблема тут в сортировке.
Есть два пути по которому можно пойти:

* оптимизировать запрос с изменением work_mem
* воспользоваться пагинацией

Я выбираю пагинацию как более простой и эффективный способ, с использованием гема https://github.com/ddnexus/pagy т.к он достаточно быстр + проблемы в скорости ответа от базы уже нет, тут больше оптимизация скорости рендера.

Есть еще seq scan не особо оптимальный, но пока он не мешает, поэтому его тоже опустим.

## Итог

Удалось для 1к трипов с 1000+ запросов сократить до 3 и увеличеть скорость рендеринга с 20 до 3сек без пагинации и до 120мс с пагинацией

# Проблема №3

Необходимо за минимальное время загрузить 10млн записей в базу, и текущая реализация не удовлетворяет требованием т.к грузит весь файл в память. Причем файл на столько большой, что ломает команду less (первый раз такое вижу :) )

Бюджет по потреблению памяти < 200мб

В этот раз решил не разбирать файл по паттернам для парсинга, а воспользоваться библиотекой которая заточена под парсинг больших json файлов в SAX  стиле. В итоге перебрал с десяток гемов с куцой докой, такое ощущение, что подобной проблемой вообще не занимались. Даже популярный OJ ломается когда я пытаюсь описать правила парсинга в SAX стиле... В итоге решил пойти путем самого простого парсинга по паттерну и аккумуляции промежуточных вместе с bulk вставкой в базу. Предложенный вариант из задачи мне не понравился, в силу запутанности, и человек в новь пришедший на проект просто-напросто может запутаться в логике перебора символов. Пусть у меня будет даже медленнее, но зато читаемость выше)

В итоге стало даже лучше, чем в первой итерации оптимизации rake таски

для large данных стало

```
Time: 12.44
Memory before: 88.28 MB
Memory after: 138.81 MB
Memory real: 50.54 MB
```

Для hardcore получилось 22 минуты. Даже интересно какой самый лучшый результат был у коллег?)

```
➜ ./bin/rake reload_json\["fixtures/hardcore.json"\]
Time: 1340.73 # ~22 минуты
Memory before: 89.52 MB
Memory after: 181.4 MB
Memory real: 91.88 MB
```

Дальнейшее оптимизации делать не буду, хотя на глаз конечно же есть пару моментов которые хочется поправить) Главное цель достигнута для импорта аномально большого файла. К тому же хотелось сохранить максимальную читаемость скрипта для разработчиков любого уровня без всяких хитрых способов с посимвольным чтением и копированием через \copy  ну и сохранить максимально интуитивный подход.
