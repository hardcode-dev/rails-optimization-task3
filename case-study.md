# Загрузка файла

Прикрутил логи и загрузил в `pgbadger`. Первое на что обращаешь внимание - кол-во запросов.

У нас нет `Rails 6`, поэтому вместо `insert_all` будем писать запросы на `SQL`.
```
City.insert_all(cities_names.map { |name| { name: name } })
```

Готово! большой файл загружается за 6 секунд:
```
== Loading data from fixtures/large.json ==
Done! it took: 6.605176 sec.

 $ rails c
Loading development environment (Rails 5.2.8.1)
irb(main):001:0> Bus.count
   (0.7ms)  SELECT COUNT(*) FROM "buses"
=> 1000
irb(main):002:0> Trip.count
   (13.2ms)  SELECT COUNT(*) FROM "trips"
=> 100000
```
