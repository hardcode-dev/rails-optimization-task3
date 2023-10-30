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

# Загрузка страницы

Начальное время - 16 секунд.
```
Completed 200 OK in 16361ms (Views: 15437.2ms | ActiveRecord: 910.2ms)
```
Судя по логам, есть работа для `bullet`.

```
 CACHE Bus Load (0.0ms)  SELECT  "buses".* FROM "buses" WHERE "buses"."id" = $1 LIMIT $2  [["id", 793], ["LIMIT", 1]]
  ↳ app/views/trips/_trip.html.erb:5
  Rendered trips/_trip.html.erb (3.4ms)
  CACHE Service Load (0.0ms)  SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1  [["bus_id", 793]]
```

Гем говорит о целесообразности добавления `.includes(:bus)`. Правда, что странно - предлагает это сделать во вью. Мне кажется, лучше будет сделать в контроллере - и будем использовать `preload` в вместо `includes`.

Время изменилось, но не существенно:
```
Completed 200 OK in 13197ms (Views: 12532.7ms | ActiveRecord: 649.9ms)
```

Молодец, `bullet`! Подсказывает не забыть подгрузить `services` тоже. Все, больше для него работы нет.


```
Completed 200 OK in 13902ms (Views: 13840.6ms | ActiveRecord: 47.7ms)
```

Установили `rack-mini-profiler`. Обращаем внимание на то, что его включение в `initializer` добавляет добрых 10 секунд!

```
Completed 200 OK in 20086ms (Views: 20004.5ms | ActiveRecord: 64.6ms)
```

Видим, что много занимает рендеринг `_services`.

Пробуем воспользоваться рельсовым рендерингом коллекции:
```
  <% render services %>
```

Видим результат!

```
Completed 200 OK in 14502ms (Views: 14465.4ms | ActiveRecord: 31.2ms)
```

Не совсем ясно, что можно улучшить с `services`. Смотрим в соседний по весу `_trip` и видим использование `present?`. Но ведь мы знаем, что `any?` в данном случае лучше!
```
Completed 200 OK in 12502ms (Views: 12462.2ms | ActiveRecord: 33.8ms)
```

Учитывая большое кол-во данных, кажется, нам не обойтись без кэширования `partials`.
Добавили `cache` в темплейты, включили `rails dev:cache`.

В результате имеем результат:
```
Completed 200 OK in 979ms (Views: 939.0ms | ActiveRecord: 35.3ms)
```

До сих пор мы (помимо `preload` и `any?`) занимались улучшением загрузки `partials`.
Что кажется верным, т.к. бд не видится боттлнеком в данном примере. Но все же добавим индексы:
```
add_index :cities, :name, unique: true
add_index :buses_services, :bus_id
add_index :trips, [:from_id, :to_id]
```

Так. Давайте все же считать кэширование "нечестным" способом оптимизации здесь, и посмотрим, что сможем "выжать" из страницы без него.

Снимаем показатели:
```
Completed 200 OK in 4403ms (Views: 4382.7ms | ActiveRecord: 15.7ms)
```

Много времени занимает `delimiter`. Видимо, подхватывание `partial` не бесплатно, и раз уж мы говорим об оптимизации, нам можно обойтись без отдельного темплейта в данном случае.

```
Completed 200 OK in 3043ms (Views: 3022.1ms | ActiveRecord: 16.9ms)
```

Что ж, пойдем дальше - и весь код `html` соберем в `index.html.erb`.

Уже неплохой результат!
```
Completed 200 OK in 455ms (Views: 434.0ms | ActiveRecord: 17.1ms)
Completed 200 OK in 473ms (Views: 449.4ms | ActiveRecord: 15.2ms)
```

Стремимся к 50 ms.

Заменили тип `start_time` на `time` в БД, стало немного лучше:
```
Completed 200 OK in 397ms (Views: 381.6ms | ActiveRecord: 11.5ms)
```
