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