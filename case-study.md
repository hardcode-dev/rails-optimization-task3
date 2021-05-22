До начала всех оптимизации я установить progressbar в rake задачу импорта и замерил время выполнения 
Получилось
- small.json ~7 секунд
- medium.json ~90 секунд
- large.json ~15 минут по ETA прогресс бара

Метрика, которую будем оптимизировать – время импорта на объеме small.json
До оптимизаций – 7.30 секунд

Фидбек луп стандартный
- внесение изменений
- просмотр инструмент
- тесты зеленые

Оптимизация 1

- По отчету pghero было видно, что в топе запрос
```
SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1
```
построив визуальное представление запроса видно, что 88% времени уходит на seq scan on buses_services 

- добавляю индекс на buses_services.bus_id в надежде, что теперь будет обращение исключительно к индексу
- Метрика realtime улучшилась 7.30 -> 7.0, в из Explain ушел Seq Scan и сменился на Index Scan using index_buses_services_on_bus_id on buses_services 

Оптимизация 2

- По отчету pghero на втором месте запрос

```
SELECT  $4 AS one FROM "buses" WHERE "buses"."number" = $1 AND "buses"."id" != $2 LIMIT $3
```

Analize показывает Seq Scan и Total Cost = 18.2

– Добавил индекс на поле number
- Seq Scan -> Index Scan и Total Cost стал равен 8.29. Метрика улучшилась 7.0 -> 6.54

Оптимизация 3
- По отчету pghero в топе был запрос на добавление
```
INSERT INTO "buses_services" ("bus_id", "service_id") VALUES ($1, $2) RETURNING "id"
```
Так как данных о сервисах мало, я решил провести денормализацию и перенести сервисы в json поле таблицы buses

- Время обработки small.json сократилось до 3.5 секунд


Оптимизация 4. city name index
- Топ pghero
```
SELECT  "cities".* FROM "cities" WHERE "cities"."name" = $1 LIMIT $2

```
- добавляю индекс на поле name
- Результатов эта оптимизация не дала. Время выполнения скрипта не изменилось. Explain запроса по прежнему показывал Seq Scan...

Оптимизация 5. Мемоизация городов
- в топе pghero по прежнему находится запрос 
```
SELECT  "cities".* FROM "cities" WHERE "cities"."name" = $1 LIMIT $2
```
Он вызывается больше всего за период работы скрипта

- На вкладке Space pghero я вижу что таблица cities небольшая по сравнению с остальными. Создаю массив в памяти CITIES куда буду складывать уже запрошенные из базы города. Так количество запросов к базе должно сократиться

- В результате запрос пропал из топа pghero. А время работы скрипта сократилось до 2.5 секунд