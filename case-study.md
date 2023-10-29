# Загрузка файла

Прикрутил логи и загрузил в `pgbadger`. Первое на что обращаешь внимание - кол-во запросов.

У нас нет `Rails 6`, поэтому вместо `insert_all` будем писать запросы на `SQL`.
```
City.insert_all(cities_names.map { |name| { name: name } })
```

Готово! большой файл загружается за 4 секунд:
```
== Loading data from fixtures/large.json ==
Done! it took: 4.770822 sec.

###

 $ b rails c
Loading development environment (Rails 5.2.8.1)
irb(main):001:0> Bus.count
   (0.6ms)  SELECT COUNT(*) FROM "buses"
=> 1000
irb(main):002:0> Service.count
   (0.5ms)  SELECT COUNT(*) FROM "services"
=> 10
irb(main):003:0> Trip.count
   (7.6ms)  SELECT COUNT(*) FROM "trips"
=> 100000
irb(main):004:0> City.count
   (0.5ms)  SELECT COUNT(*) FROM "cities"
=> 10
irb(main):005:0> Bus.last.services
  Bus Load (0.3ms)  SELECT  "buses".* FROM "buses" ORDER BY "buses"."id" DESC LIMIT $1  [["LIMIT", 1]]
  Service Load (1.2ms)  SELECT  "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1 LIMIT $2  [["bus_id", 1000], ["LIMIT", 11]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Service id: 1, name: "WiFi">, #<Service id: 8, name: "Туалет">, #<Service id: 2, name: "Работающий туалет">, #<Service id: 3, name: "Кондиционер общий">, #<Service id: 4, name: "Кондиционер Индивидуальный">, #<Service id: 5, name: "Телевизор общий">, #<Service id: 6, name: "Телевизор индивидуальный">, #<Service id: 10, name: "Стюардесса">, #<Service id: 7, name: "Можно не печатать билет">]>

```

# Загрузка файла

Начинаем с того, что дождаться загрузки страницы не удается:
```
  CACHE Bus Load (0.0ms)  SELECT  "buses".* FROM "buses" WHERE "buses"."id" = $1 LIMIT $2  [["id", 813], ["LIMIT", 1]]
  ↳ app/views/trips/_trip.html.erb:5
  Rendered trips/_trip.html.erb (1.5ms)
  CACHE Service Load (0.0ms)  SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1  [["bus_id", 813]]
  ↳ app/views/trips/index.html.erb:11
  Rendered trips/_service.html.erb (0.0ms)
  # ...
  Rendered trips/_services.html.erb (173.9ms)
  Rendered trips/_delimiter.html.erb (0.0ms)
  Bus Load (0.4ms)  SELECT  "buses".* FROM "buses" WHERE "buses"."id" = $1 LIMIT $2  [["id", 106], ["LIMIT", 1]]
  ↳ app/views/trips/_trip.html.erb:5
  Rendered trips/_trip.html.erb (1.6ms)
  Service Load (33.1ms)  SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1  [["bus_id", 106]]
  ↳ app/views/trips/index.html.erb:11
  Rendered trips/_service.html.erb (0.0ms)
  # ...
```

Нам нужно что-то сделать с повторяющейся:
```
 Rendered collection of services/_service.html.erb [535 times] (3.4ms)
```

Заменяем запись на:
```
  <% render services %>
```

Убеждаемся, что `rails` помогает нам более эффективно рендерить коллекции:
```
  Rendered collection of services/_service.html.erb [495 times] (3.1ms)
```

Ура! страница теперь грузится. Время: 40 секунд.

Обращаем внимание на повторяющиеся запросы `bus` и `service`:
```
 CACHE Bus Load (0.0ms)  SELECT  "buses".* FROM "buses" WHERE "buses"."id" = $1 LIMIT $2  [["id", 771], ["LIMIT", 1]]
  ↳ app/views/trips/_trip.html.erb:5
  Rendered trips/_trip.html.erb (2.3ms)
  CACHE Service Load (0.0ms)  SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1  [["bus_id", 771]]
  ↳ app/views/trips/index.html.erb:11
  Rendered collection of services/_service.html.erb [279 times] (1.9ms)
  Rendered trips/_services.html.erb (3.9ms)
  Rendered trips/_delimiter.html.erb (0.0ms)
```

Добавим `preload` в `TripsController`:
```
@trips = Trip.where(from: @from, to: @to).order(:start_time).preload(bus: :services)
```

Обратил внимание, что у меня не отображаются услуги по автобусам. Вероятно, какая-то проблема с миграцией. Проверим.
