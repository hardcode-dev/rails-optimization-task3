# Case-study оптимизации

## Актуальная проблема
В нашем проекте возникла серьёзная проблема.

При росте количес ва автобусов и поездок оченьб сильно росло время отображения страницы маршрутов


## Формирование метрики
Для того, чтобы понимать, дают ли мои изменения положительный эффект на быстродействие программы я придумал использовать такую метрику: 


время загрузки страницы http://localhost:3000/автобусы/Самара/Москва

Начали мы с вот такой метрики 
Completed 200 OK in 17979ms (Views: 16614.2ms | ActiveRecord: 1354.8ms)


## Гарантия корректности работы оптимизированной программы

Я уже добавил тест который загружает example.json и сверяет ответ сервера на запрос Москва-Самара с эталоном (до оптимизаций)

## Feedback-Loop
Для того, чтобы иметь возможность быстро проверять гипотезы я выстроил эффективный `feedback-loop`, который позволил мне получать обратную связь по эффективности сделанных изменений за *время, которое у вас получилось*

Вот как я построил `feedback_loop`: 
В качестве фидбек лупа я использовал открытие страницы http://localhost:3000/автобусы/Самара/Москва
что позволило тратить 12с на фидбек луп

## Вникаем в детали системы, чтобы найти главные точки роста
Судя по логу консоли присутствует очень много n+1 начнем с bullet


### Ваша находка №1

USE eager loading detected
  Trip => [:bus]
  Add to your query: .includes([:bus])
  
После чего сразу 
USE eager loading detected
  Bus => [:buses_services]
  Add to your query: .includes([:buses_services])
  
USE eager loading detected
  Bus => [:services]
  Add to your query: .includes([:services])    

Итого получаем 

    .includes(bus: :services)

И время 5143ms


### Ваша находка №2
Я пошел смотреть какие запросы мы делаем к СУБД

- Сначала 2 запроса к городам для поиска городов, тут вроде ничего не сделать и они быстрые
- Select count(*) from trips where 
- Trip Load (27.0ms)  SELECT "trips".* FROM "trips" - тут явно не хватает индекса
- предзагрузка Bus Load (3.5ms)   SELECT "buses".* FROM "buses" WHERE "buses"."id" IN ($
- предзагрузка BusesService  (44.8ms)  SELECT "buses_services".*
- предзагрузка сервисов Service Load (0.6ms)  SELECT "services


Поехали разбираться
- Select count(*) from trips where  это нам легко убрать заменив @trips.count на длину массива @trips.load.length
Ничто не выполняется быстрее чем отсутствие запроса тут можно даже не тестировать


- SELECT "trips".* FROM "trips" WHERE "trips"."from_id" = $1 AND "trips"."to_id" = $2 ORDER BY "trips"."start_time" ASC

        Sort  (cost=2465.01..2467.43 rows=968 width=34) (actual time=41.276..41.427 rows=1004 loops=1)
          Sort Key: start_time
          Sort Method: quicksort  Memory: 103kB
          ->  Seq Scan on trips  (cost=0.00..2417.00 rows=968 width=34) (actual time=0.024..31.899 rows=1004 loops=1)
                Filter: ((from_id = 516) AND (to_id = 517))
                Rows Removed by Filter: 98996
        Planning Time: 0.171 ms
        Execution Time: 41.573 ms

Привет Seq Scan

    add_index :trips, [:from_id, :to_id, :start_time]
   
Стало лучше

    Sort  (cost=1039.24..1041.66 rows=968 width=34) (actual time=9.423..9.723 rows=1004 loops=1)
      Sort Key: start_time
      Sort Method: quicksort  Memory: 103kB
      ->  Bitmap Heap Scan on trips  (cost=22.21..991.23 rows=968 width=34) (actual time=0.443..1.357 rows=1004 loops=1)
            Recheck Cond: ((from_id = 516) AND (to_id = 517))
            Heap Blocks: exact=577
            ->  Bitmap Index Scan on index_trips_on_from_id_and_to_id  (cost=0.00..21.97 rows=968 width=0) (actual time=0.315..0.316 rows=1004 loops=1)
                  Index Cond: ((from_id = 516) AND (to_id = 517))
    Planning Time: 0.133 ms
    Execution Time: 9.901 ms
   
- SELECT "buses".* FROM "buses" WHERE "buses"."id" IN () - тут поиск по primary key не знаю что можно сделать

- explain analyze SELECT "buses_services".* FROM "buses_services" WHERE "buses_services"."bus_id" IN 

        Seq Scan on buses_services  (cost=0.00..107.68 rows=5 width=16) (actual time=0.693..0.711 rows=6 loops=1)
          Filter: (bus_id = 31936)
          Rows Removed by Filter: 4528
        Planning Time: 0.067 ms
        Execution Time: 0.729 ms



    add_index :buses_services, [:bus_id, :service_id]
    
И сразу стало лучше

    Index Scan using index_buses_services_on_bus_id_and_service_id on buses_services  (cost=0.28..15.37 rows=5 width=16) (actual time=0.059..0.062 rows=6 loops=1)
      Index Cond: (bus_id = 31936)
    Planning Time: 0.488 ms
    Execution Time: 0.114 ms

Но я подумал что тут можно докрутить до IndexOnlyScan для этого надо явно указать колонки но как это сделать так и не смог разобраться
я смог нагуглить примеры по типу belongs_to :user_restricted, -> { select(:id, :email) }, class_name: 'User' но у меня они не заработали с промежуточной таблицей

Наконец SELECT "services".* FROM "services" WHERE "services"."id" IN тоже поиск по праймари кею не уверен что можно оптимизировать


### Ваша находка №3 
Тут очень много рендеринга партиалов, мы сейчас это оптимизируем но надо перейти на production env так как есть большая разница в работе с партиалами на dev и productions


Помогать определять среднее время нам будет простенький скрипт 
https://gist.github.com/kevindees/a24dd20d81e974e2a72cbf03c2550c80

Avg: .90188c

Делаем так 
    
    <li>Сервисы в автобусе:</li>
    <ul>
      <%= render partial: 'service', collection: services %>
    </ul>
    
Avg: .65505


Дальше я убрал часть партиалов с целью оптимизации и получил вот такой парттиал _trip

    <ul>
      <li><%= "Отправление: #{trip.start_time}" %></li>
      <li><%= "Прибытие: #{(Time.parse(trip.start_time) + trip.duration_minutes.minutes).strftime('%H:%M')}" %></li>
      <li><%= "В пути: #{trip.duration_minutes / 60}ч. #{trip.duration_minutes % 60}мин." %></li>
      <li><%= "Цена: #{trip.price_cents / 100}р. #{trip.price_cents % 100}коп." %></li>
      <li><%= "Автобус: #{trip.bus.model} №#{trip.bus.number}" %></li>
    
      <% if trip.bus.services.present? %>
        <li>Сервисы в автобусе:</li>
        <ul>
          <%= render partial: 'service', collection: trip.bus.services %>
        </ul>
      <% end %>
    </ul>
    
    ====================================================
    
Это уже работает за 
Avg: .42295    
    



## Результаты


## Защита от регрессии производительности

