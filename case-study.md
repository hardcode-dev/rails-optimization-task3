# Case-study оптимизации

## Шаги

- Настройка профилировщиков: pghero, rack-mini-profiler

- Написание теста для проверки результата вывода

- Борьба с репозиторием и настройкой постгрес

- Начальная метрика 5 сек

# Находка 1:
  - в топе pghero запрос
  `SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1`, вызывается в строке `bus.update(model: trip['bus']['model'], services: services)`
  - Вынесем создание buses_services из цикла, а также уберем лишний update для bus
  - Метрика сократилась до 2.87 сек (память: 104MB), точка роста изменилась

# Находка 2:
  - в топе pghero запрос
  `SELECT  "buses".* FROM "buses" WHERE "buses"."number" = $1 LIMIT $2`, вызывается в строке `bus = Bus.find_or_initialize_by(number: attrs['number'])`
  - Добавим рекомендованный индекс на колонку, а также поменяем тип колонки на integer
  - Метрика незначительно сократилась до 2.81 сек (память: 102MB), точка роста изменилась

# Находка 3:
  - в топе pghero запрос
  `SELECT  "services".* FROM "services" WHERE "services"."name" = $1 LIMIT $2`, вызывается в строке `Service.find_or_create_by(name: service_name)`
  - Т.к сервисов весьма ограниченное количество и имена их известны - мы можем создать их заранее и исключить проверку из цикла
  - Метрика сократилась до 1.8 сек (память: 102MB), точка роста изменилась
