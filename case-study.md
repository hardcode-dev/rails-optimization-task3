# Импорт
Время выполнения на small.json снизилось с 26с до 3c

На large время выполнения ~60с

# Страница с данными

До изменений время загрузки страницы(small.json) - 512ms:

`Completed 200 OK in 512ms (Views: 363.4ms | ActiveRecord: 131.7ms)`

После исправления N+1:

`Completed 200 OK in 212ms (Views: 156.7ms | ActiveRecord: 48.0ms)`

После добавления индексов:

`Completed 200 OK in 179ms (Views: 161.4ms | ActiveRecord: 16.0ms)`

Во вьюхе можно изпользовать `trips.length` вместо `.count`, особо скорость не изменится, но запрос лишний уберется

Если убрать рендер `_trip.html.erb`, то уменьшится до 100ms:
`Completed 200 OK in 97ms (Views: 81.3ms | ActiveRecord: 13.4ms)`

Если убрать все рендеры, то опускается до 80ms:
`Completed 200 OK in 83ms (Views: 68.9ms | ActiveRecord: 12.4ms)`

