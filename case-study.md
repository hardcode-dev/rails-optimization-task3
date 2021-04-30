# Задание №3

## План
- [x] Сделать тест на корректность
- [x] Переделать загрузку на activerecord-import
- [x] Сделать тест на производительность
- [x] Оптимизировать загрузку в бюджете
- [x] Оптимизировать отдачу
    - [x] `rack-mini-profiler`
    - [x] `rails panel`
    - [x] `bullet`
    - [x] `explain` запросов
- [ ] Оптимизировать загрузку для обработки 1M записей
- [ ] Оптимизировать загрузку для обработки 10M записей

## Загрузка JSON из 100 тыс. записей 
Изначальная загрузка была неоптимальна, и это было заметно. Воспользовался идеей переделать ее с использованием гема `activerecord-import`. При разработке учитывались такие моменты:

1. Обойти JSON-файл один раз. 
2. Писать в БД сразу короткие таблицы (`cities` и `services`)
3. Для остальных таблиц -- создавать данные в памяти при обходе JSON, затем загружать их через вызов `#import`
4. По возможности для этих данных использовать только атирибуты, а не сами объекты.
5. Для HABTM-связки `buses<->services` создать промежутучную структуру, заполнить и импортировать.

При запуске полученного решения выяснилось, что оно отрабатывает за **~28 секунд**, бюджет был достигнут сразу же. Дальнейшая оптимизация в рамках этого пункта не потребовалась.

## Оптимизация отдачи
Запросы можно посмотреть с помощью `rack-mini-profiler` и `RailsPanel`. По ним видны такие неоптимальности при выборке из БД:
- Есть `COUNT(*)`-запрос в `trips`
- Есть "2N+1" запросами:
  - `SELECT  "buses".* FROM "buses" WHERE "buses"."id" = $1 LIMIT $2; `
  - `SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1; `

Последнее подтверждается `bullet`:
- `USE eager loading detected Trip => [:bus] Add to your query: .includes([:bus])`
- `USE eager loading detected Bus => [:buses_services] Add to your query: .includes([:buses_services])`
  
  ` USE eager loading detected Bus => [:services] Add to your query: .includes([:services])`

Оптимизируем связи в запросе через `JOIN` для того, чтобы получить один запрос. При этом `bullet` продолжает предлагать оптимизацию, хотя, в ней уже нет смысла.

Запросы в `cities` не оптимизируем, их всего два и они быстрые.

Получаем план выполнения запроса выборки через`explain`:
```
                                        QUERY PLAN                                         
-------------------------------------------------------------------------------------------
 Sort  (cost=3257.24..3257.26 rows=5 width=96)
   Sort Key: trips.start_time
   ->  Nested Loop  (cost=3167.42..3257.19 rows=5 width=96)
         ->  Nested Loop  (cost=3167.29..3256.41 rows=5 width=61)
               Join Filter: (trips.bus_id = buses.id)
               ->  Hash Join  (cost=3167.01..3254.40 rows=5 width=42)
                     Hash Cond: (buses_services.bus_id = trips.bus_id)
>>>>>>>>>>>>>>>>>>>> ->  Seq Scan on buses_services  (cost=0.00..70.34 rows=4534 width=8)
                     ->  Hash  (cost=3167.00..3167.00 rows=1 width=34)
>>>>>>>>>>>>>>>>>>>>>>>>>> ->  Seq Scan on trips  (cost=0.00..3167.00 rows=1 width=34)
                                 Filter: ((from_id = 700) AND (to_id = 691))
               ->  Index Scan using buses_pkey on buses  (cost=0.28..0.39 rows=1 width=23)
                     Index Cond: (id = buses_services.bus_id)
         ->  Index Scan using services_pkey on services  (cost=0.14..0.16 rows=1 width=39)
               Index Cond: (id = buses_services.service_id)
```
План запроса показывает, что происходит sequential scan при выборки из таблицы `trips` и таблицы-связки `buses_services`. Первый -- тяжелый, второй -- не особенно.

Делаем миграцию БД, убирающую ненужную колонку `id` в `buses_services`, создающую в ней новый композитный PK по `bus_id`, `service_id` и создающую в `trips` индекс по колонкам `from_id, to_id`.

План выполнения запроса после этого исключает sequential scan-ы и показывает приемлемую оценку:
```
                                                      QUERY PLAN                                                       
-----------------------------------------------------------------------------------------------------------------------
 Sort  (cost=15.55..15.56 rows=5 width=96)
   Sort Key: trips.start_time
   ->  Nested Loop  (cost=0.98..15.49 rows=5 width=96)
         ->  Nested Loop  (cost=0.85..14.71 rows=5 width=61)
               Join Filter: (trips.bus_id = buses.id)
               ->  Nested Loop  (cost=0.57..12.71 rows=5 width=42)
                     ->  Index Scan using index_trips_on_from_id_and_to_id on trips  (cost=0.29..8.29 rows=1 width=34)
                           Index Cond: ((from_id = 700) AND (to_id = 691))
                     ->  Index Only Scan using buses_services_pkey on buses_services  (cost=0.28..4.37 rows=5 width=8)
                           Index Cond: (bus_id = trips.bus_id)
               ->  Index Scan using buses_pkey on buses  (cost=0.28..0.39 rows=1 width=23)
                     Index Cond: (id = buses_services.bus_id)
         ->  Index Scan using services_pkey on services  (cost=0.14..0.16 rows=1 width=39)
               Index Cond: (id = buses_services.service_id)
```
