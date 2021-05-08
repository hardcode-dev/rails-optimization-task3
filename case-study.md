# Задание №3

В этом задании предлагается оптимизировать учебное `rails`-приложение.

Для запуска потребуется:
- `ruby 2.6.3`
- `postgres 12`

Запуск и использование:
- `bundle install`
- `bin/setup`
- `rails s`
- `open http://localhost:3000/автобусы/Самара/Москва`

## Описание учебного приложения
Зайдя на страницу `автобусы/Самара/Москва` вы увидите расписание автобусов по этому направлению.

## Что оптимизировано

### A. Импорт данных
При выполнении `bin/setup` в базу данных загружаются данные о рейсах из файла `fixtures/small.json`

Сама загрузка данных из файла делается очень наивно (и не эффективно).

В комплекте с заданием поставляются файлы
- `example.json`
- `small.json` (1K трипов)
- `medium.json` (10K трипов)
- `large.json` (100K трипов)

Нужно оптимизировать механизм перезагрузки расписания из файла так, чтобы он импортировал файл `large.json` **в пределах минуты**.

`rake reload_json[fixtures/large.json]`

**Суть проблемы:**
- `small.json` загружается за 2 минуты
- `medium.json` загружается свыше 10 минут

#### Этап №1
- Вынесли код в сервисы и подготовили инфракструктуру для анализа операции загрузки данных

Теперь можно выполнить Rake-задачу  по загрузке в БД  из файла `fixtures/small.json` 1000 записей о поездках с предварительной очисткой БД от старых данных
```bash
$ bin/rake reload_json[fixtures/small.json,1000,true]
== Loading data from fixtures/small.json ==
Memory: 93208 KB
Deleting old data 
Наивная загрузка данных из json-файла в БД
[##############################] [1000/1000] [100.00%] [01:55] [00:00] [   8.63/s]
Memory: 103288 KB
Memory usage: 10080 KB
Finish in: 116.15
```
- сгенерировали отчет с помощью **pgBadger** в `pgBadger/out_Naive_loading.html`

В разделе Top смотрим секции `Most frequent queries`, `Time consuming queries` и отмечаем довольно большую расходную часть запросов типа `SELECT . FROM . WHERE . LIMIT`, `SELECT . FROM . INNER . JOIN . ON . WHERE .` Предполагается излишеством расход времени на такие запросы на этапе формирования БД.
Смотрим секции `Time consuming prepare` и `Time consuming bind` и видим здесь небольшие затраты времени на необходивые массовые операции встравки данных `INSERT . INTO`

#### Этап №2
- Реализовали массовую загрузку при поддержке `gem 'activerecord-import'`
```bash
Memory: 88552 KB
Deleting old data 
Массовый импорт данных из json-файла в БД
[##############################] [1000/1000] [100.00%] [00:01] [00:00] [ 516.14/s]
                           user     system      total        real
Import Cities          0.009197   0.004254   0.013451 (  0.016776)
Import Buses           0.454826   0.023272   0.478098 (  0.523450)
Import Bus Services    1.683154   0.032181   1.715335 (  1.892662)
Import Trips           1.612631   0.018995   1.631626 (  1.719136)

Memory: 110720 KB
Memory usage: 22168 KB
Finish in: 6.16
```
За счёт увеличения используемой памяти в два раза по сравнению с наивной загрузкой для массовой загрузки получили ускорение в 20 раз.

- По статистике pgBadger самый сложный запрос в `pgBadger/out_Bulk_import.html` стал
`INSERT INTO "buses_services" ("id","bus_id","service_id") VALUES . ` Он попал в категории:
```bash
Slowest individual queries  51ms
Time consuming queries      51ms
Normalized slowest queries  51ms
Time consuming prepare      75ms
Time consuming bind         23ms
```

#### Этап №3
- Реализовали потоковый импорт
- После обработки файла данных `fixtures/small.json` сгенерировали отчет с помощью **pgBadger** в `pgBadger/out_Streaming_import.html` 

В отчетах появился трудоёмкий сервисный запрос `copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter` на 1s533ms в секциях `Slowest individual queries` и `Time consuming queries` 

Самым долговременным SQL-запросом в статистике оказался `INSERT INTO "buses_services" ("bus_id", "service_id") VALUES . `  по следующим категориям:
```bash
Slowest individual queries  49ms
Time consuming queries      49ms
Normalized slowest queries  49ms
Time consuming prepare      22ms
Time consuming bind         11ms
```
 Получили очевидное ускорение по SQL-запросам по сравнению с предыдущим этапом оптимизации алгоритма импорта данных в БД из JSON-файла.

- Статистика по расходу памяти при загрузке файлов различного объема выглядит следующим образом.
```bash
$ bin/rake reload_json[fixtures/small.json,1000,true,true]
Memory: 93396 KB
Deleting old data 
Поковый импорт данных из json-файла в БД
[##############################] [1000/1000] [100.00%] [00:02] [00:00] [ 458.77/s]
Memory: 97764 KB
Memory usage: 4368 KB
Finish in: 3.78
```
```bash
$ bin/rake reload_json[fixtures/medium.json,10000,true,true]
Memory: 92924 KB
Deleting old data 
Поковый импорт данных из json-файла в БД
[##############################] [10000/10000] [100.00%] [00:17] [00:00] [  585.93/s]
Memory: 98324 KB
Memory usage: 5400 KB
Finish in: 19.7
```
```bash
$ bin/rake reload_json[fixtures/large.json,100000,true,true]
Memory: 92240 KB
Deleting old data 
Поковый импорт данных из json-файла в БД
[##############################] [100000/100000] [100.00%] [02:36] [00:00] [  637.47/s]
Memory: 98336 KB
Memory usage: 6096 KB
Finish in: 159.28
```
Из приведённых данных видно, что изменение объёма импортируемых данных на два порядка даёт прирост в потреблении памяти только на 50%. 

Ускорение обработки данных по сравнению с предыдущим этапом составило порядка 30%.


### Б. Отображение расписаний
Сами страницы расписаний формируются не эффективно и при росте объёмов начинают сильно тормозить.

Нужно найти и устранить проблемы, замедляющие формирование этих страниц.

#### Этап №1
- Столкнулся с проблемой в bullet
```bash
USE eager loading detected
  Bus::HABTM_Services => [:service]
  Add to your query: .includes([:service])
```
- Принял решение исправить связь `многие ко многим` для моделей Bus и Service через отношение `has_many :through`

#### Этап №2
- Предложил решение проблемы N+1
- **Вариант 1.** `eager_load(bus: :services)` – `bullet` оставлял предупреждения о необходимости подключения `.includes([:buses_services])`
- **Вариант 2.** `preload(bus: :services)` – `bullet` перестал сообщать о проблемах

#### Этап №3
- `rack-mini-profiler` после первого шага давал 17 запросов на странице, а после второго шага оставил только 7
- при переходе с массива данных small.json на medium.json количество запросов не изменилось
- В последнем случае самый сложный запрос* выполнялся 39ms. В основном время тратилось на отрисовку страницы ~ 10 секунд
```bash
SELECT "buses_services".* FROM "buses_services" WHERE "buses_services"."bus_id" IN ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98)
```
