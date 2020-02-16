# Case-study оптимизации импорта данных в БД

## Актуальная проблема
Текущая задача веб-приложения - отображение автобусных рейсов. Данные для отображения берутся из
базы данных. В базу данных они попадают с помощью `rake task'a` `:reload_json`, находящегося в
`utlis.rake`. Данный таск импортирует данные из `json` файла, передаваемого ему в качестве 
параметра, в базу данных.  
При больших объемах данных таск работает слишком медленно, в связи с чем было принято решение его
оптимизировать.

## Формирование метрики
За метрикой было взято время импорта в базу данных. Для ее приблизительного формирования был 
использован метод `Time::now`. Файл `medium.json`, содержащий 10_000 записей импортируется в базу
данных за 60.388 секунд. В качестве бюджета метрики было задано время ипорта в базу данных в 60
секунд для файла `large.json`, содержащего 100_000 записей.

## Гарантия работы оптимизированной программы
Для гарантии работы оптимизированной программы было решено покрыть данный `rake task` тестами с
использованием библиотеки `rspec`.

## Feedback-Loop
Для эффективной оптимизации был выстроен следующий `feedback-loop`: Профилирование с использованием
`ruby-prof` и `pghero`-> Оптимизация -> Проверка работы программы с использованием тестов -> 
Закрепление результатов оптимизации с помощью тестов, написанных с использованием библиотеки 
`rspec-benchmark`.

## Анализ ассимптотики
Для анализа ассимптотики файл `small.json`, содержащий 10_000 записей был поделен на небольшие
файлы, содержащие 1000, 2000, 3000, 4000 и 5000 записей. В результате сбора метрики была выявлена 
следующая ассиптотика:  
1 1000 строк - 7.847 секунды  
2 2000 строк - 13.851 секунд  
3 3000 строк - 19.965 секунд  
4 4000 строк - 26.765 секунд  
5 5000 строк - 31.808 секунд  
Исходя из данного анализа был сделан вывод, что ассимптотика меньше линейной. Однако с такой 
ассимптотикой в поставленный бюджет не уложиться.

## Анализ точек роста
Для анализа основных точек роста был взят сэмпл файл на 300 строк, `300.json`, так как с ним фидбек 
луп занимает меньше 3-х секунд. Так как не было написано тестов, проверяющих функционал данного 
`rake task`'a, было решено начать с написания тестов.

### Написание тестов для проверки работы импорта данных
Так как ни одного теста не было написано, было решено заменить библиотеку для тестирования на
`rspec`. В процессе тестирования было решено вынести данный `rake task` в отдельный файл для
удобства масштабирования и тестирования тасков в проекте.

### Анализ загрузки данных из JSON'a в базу данных
Первое профилирование на тестовых данных было произведено с помощью библиотеки `ruby-prof`. Однако,
из отчета профилировщика было только ясно, что больше всего испольется `IO::Select`, который
вызывается из `FSEvent::run`. Стало понятно, что проблема либо при считывании файла из файловой 
системы, либо при записи данных в БД, расположенную в файловой системе. Для выяснения этого был
использован подход с выводом в `$stdout` времени исполнения каждой части программы с помощью метода
`Time::now`. Данный подход позволил выяснить, что большую часть времени (на сэмпле в 2000 записей
14 s против 13 ms) производится запись данных в базу данных. В рамках импорта  
идет работа с каждым отдельным хешом из json-структуры и сам ruby код исполняется быстро, поэтому
было решено сократить количество вызовов к базе данных. Для анализа вызовов был использован 
инструмент `pghero`. Он показал, что большую часть времени работает запрос `SELECT "services".* 
FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" 
WHERE "buses_services"."bus_id" = $1`, но даже он идет 0 ms, так что проблема в количестве вызовов.

### Сокращение количества обращений в базу данных
В качестве первого шага оптимизации было решено сократить количество обращений в базу данных. Для
этого json файл был разделен на части по 1000 записей и каждые 1000 записей стали записываться в
базу данных батчами. Для реализации загрузки батчами было решено использовать библиотеку 
`activerecord-import` и метод для `ActiveRecord::Base` `import`, поставляемый этой 
библиотекой. Сложность была в импорте ассоциаций. Для корректного импорта ассоциаций была измнена
`HABTM` ассоциация на `has many through` для между моделями `Bus` и `Service`. Далее после загрузки
автобусов результат импорта был использован для создания ассоциаций между автобусами и сервисами
путем импорта в джоин таблицу (модель `BusesServices`).  
Далее было необходимо импортировать сами поездки (`Trip`) в базу данных. Так как номера автобусов
уникальны, то для привязки поездки к автобусам было решено использовать результат импорта автобусов
и их номера. Для привзяки поездок к городам было решено использовать названия городов и результат
импорта городов в БД. В итоге удалось сократить время обработки файла `large.json` до 21 секунды.
Несмотря на то, что возможна дальнейшая оптимизация, мы уже уложились в бюджет и было решено 
приступить к оптимизации отображения данных.

### Оптимизация отображение расписаний
Следующая проблема в приложении - медленное отображение расписаний при больших объемах данных. 
Тестов написано не было, поэтому было решено начать с них. Для тестирования был использован гем
`rspec` и гем `capybara`.