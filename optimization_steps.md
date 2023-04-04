1. Перед оптимизацией я занялся защитой данных. Добавил внешние ключи, индексы на уникальность. Написал тест, чтобы быть уверенным, что импорт данных работает корректно.
2. Добавил гем oj, для парсинга JSON.
3. Добавил activerecord-import, написал код, чтобы билдить данные и сохранять их одним запросом.
  В результате смог заимпортить данные из large.json и уложиться в приемлемое время.
  Результат импорта:
  => Import started
  => Import ended, took  0:32.65
  Trips count: 100000, Buses count: 1000, Cities count: 10, Services count: 10

4. Перед оптимизацией рендера страницы я написал тест, чтобы защитить рендер страницы. Добавил снапшот тест чтобы сравнивать страницу с каноничной версией страницы.
5. Рендер страницы занимает ~ 7300 ms для 1004 рейсов.
  Начал смотреть логи запроса при рендере страницы, было видно, что здесь есть n+1.
  Повторяющие запросы из логов:
    1. SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1
    2. SELECT  "buses".* FROM "buses" WHERE "buses"."id" = $1 LIMIT $2
  Добавил прелоад автобусов и сервисов, в итоге страница начала загружаться за ~4400 ms. Повторяющихся запросов больше не было.
6. Следующий анализ логов показал, что происходят тяжелых запроса к trips(16.9ms). Один, чтобы достать данные, а другой чтобы посчитать их количество
  SELECT COUNT(*) FROM "trips" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2
  SELECT "trips".* FROM "trips" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2 ORDER BY "trips"."start_time" ASC
  Убрал запрос на подсчет количества рейсов в базе данных, за счет принудительной загрузки trips и метод size, который возвращает количество элементов в массиве. Страница начала грузиться ~4200 ms
7. Следующий поход в логи показал, основное время уходит на редер паршалов, самый сложный из которых trips/_services.html.erb. Он занимает от 1ms до 3ms. Просмотр рендера страницы показал, что везде происходит проход по массиву через each, что не является оптимальным. Также сам по себе рендер паршалов очень медленный и в данном случае их неоправдано много.
  В результате упрощения рендера страницы она начала загружаться за ~240ms
8. EXPLAIN ANALYZE SELECT "trips".* FROM "trips" WHERE "trips"."from_id" = 64 AND "trips"."to_id" = 62 ORDER BY "trips"."start_time" ASC;
  Показал следующий результат:
  Sort  (cost=2383.49..2385.97 rows=994 width=34) (actual time=14.396..14.499 rows=1004 loops=1)
  Sort Key: start_time
  Sort Method: quicksort  Memory: 103kB
    ->  Seq Scan on trips  (cost=0.00..2334.00 rows=994 width=34) (actual time=0.037..13.909 rows=1004 loops=1)
          Filter: ((from_id = 64) AND (to_id = 62))
          Rows Removed by Filter: 98996
  Planning Time: 0.249 ms
  Execution Time: 14.632 ms
  Это показало, что сортировка данных происходит при помощи quicksort, а поиск по from_id и to_id не использует индекс.
  Было принято решение добавить индекс для from_id и to_id.
  В результате оптимизации я получил следующий результат:
  Sort  (cost=955.51..958.00 rows=994 width=34) (actual time=2.855..2.925 rows=1004 loops=1)
  Sort Key: start_time
  Sort Method: quicksort  Memory: 103kB
    ->  Bitmap Heap Scan on trips  (cost=14.48..906.03 rows=994 width=34) (actual time=0.249..2.405 rows=1004 loops=1)
          Recheck Cond: ((from_id = 64) AND (to_id = 62))
          Heap Blocks: exact=583
          ->  Bitmap Index Scan on index_trips_on_from_id_to_id  (cost=0.00..14.23 rows=994 width=0) (actual time=0.122..0.123 rows=1004 loops=1)
                Index Cond: ((from_id = 64) AND (to_id = 62))
  Planning Time: 1.687 ms
  Execution Time: 3.035 ms
  В результате оптимизации запрос начал проходить за ~200ms

Результаты
В результате оптимизации импорта добился приемлемого времени для необходимого объема данных ~30sec
Отимизация запросов и рендера страницы дало ускорение с 7300ms до 200ms
