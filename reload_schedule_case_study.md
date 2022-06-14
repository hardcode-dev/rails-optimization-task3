# Case study для перезагрузки расписания

### Бюджет - обрабатывать `large.json` в пределах минуты
<br>

Провел замеры по времени работы `reload_json`

`file_name: fixtures/small.json` - **Benchmark time 15.588036000030115**

`file_name: fixtures/medium.json` - **Benchmark time 120.36221100005787**

*large.json не стал ждать, понятно, что дольше чем medium*

---


Далее я вынес код в сервис `ReloadSchedule` и написал простой тест, чтобы не сломать локигу работы программы в процессе оптимизации.

В качестве метрики я выбрал скорость выполнения программы на файле `small.json` (первоначально была 15 sec)

> Feedback loop построил таким образом:

1. замеряю время выполнения программы на `samll.json`
2. делаю профилирование
3. нахожу точку роста и оптимизирую ее
4. замеряю время выполнения программы на `samll.json`, время выполнение должно стать меньше, а после профилирования точка роста должна измениться

> Первое профилирование

профилирования `small.json` c ruby-prof падала с ошибкой из за слишком глубокого стэка, перешел на `stackprof`

`
TOTAL    (pct)     SAMPLES    (pct)     FRAME
8573  (40.9%)        5063  (24.2%)     ActiveRecord::ConnectionAdapters::PostgreSQLAdapter#exec_no_cache
6908  (33.0%)        3969  (18.9%)     ActiveRecord::ConnectionAdapters::PostgreSQLAdapter#exec_cache
`

Cтало понятно, что больше всего времени проводим во внутренностях ActiveRecord, значит надо переосмыслить подход к сохранению сущностей в базе, решил не использовать предложенный гем, а обновить проект до rails 6.0.5, чтобы получить из коробки доступ к `insert_all`

---
Обновление rails прошло без проблем, но **метрика с 15 секунд поднялась до 21**

Использовал `insert_all`, но при этом оставил связь `has_and_belongs_to_many` и чтобы корректно записать туда данные для каждой пары id автобуса и сервиса открывал connection таким образом

```
ActiveRecord::Base.connection.execute(
  "INSERT INTO buses_services (bus_id, service_id) values (#{hash[:bus_id]}, #{hash[:service_id]})"
)
```

**Метрика улучшилась и стала составлять 2.24**

Отчет `stackprof`

`
2477  (70.1%)        1505  (42.6%)     ActiveRecord::ConnectionAdapters::PostgreSQL::DatabaseStatements#execute
3371  (95.4%)         403  (11.4%)     ReloadSchedule#save_entities
205   (5.8%)         193   (5.5%)     ActiveRecord::ConnectionAdapters::PostgreSQLAdapter#exec_no_cache
`
---
Перешел от связи `has_and_belongs_to_many` к `has_many, through` и теперь использую `insert_all` для модели `BusService`

**Метрика стала 0.3**

Отчет `stackprof` стал таким 

`
10575  (96.5%)        4757  (43.4%)     ReloadSchedule#save_entities
2811  (25.7%)        2792  (25.5%)     ActiveRecord::ConnectionAdapters::PostgreSQLAdapter#exec_no_cache
727   (6.6%)         727   (6.6%)     Set#add
`

> **large.json обрабатывается за 12 секунд - укладываемся в бюджет!**
---
Закрепил успех с помощью performance теста.