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