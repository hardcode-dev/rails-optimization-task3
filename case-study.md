- [X] `rack-mini-profiler`
- [X] `rails panel`
- [X] `bullet`
- [X] `explain` запросов

реализовал composite primary key (model, number) через гем 'composite_primary_keys'. Нашел интересную статью с бенчмарками различных методик загрузки данных в Postgreql - 
`https://koshigoe.github.io/postgresql/ruby/2018/10/31/bulk-insert-vs-copy-in-postgres.html`. Прогнал локально тесты из статьи и реализовал самый быстрый, что дало прирост, но меньший чем ожидал. Посчитал что текущей скорости достаточно и перешел к оптимизации отображения расписания.
- импорт данных из файла rake reload_json[fixtures/large.json] проходит за 40 секунд. 
- загрузка страницы с расписанием занимат 6-11 секунд
- не удалось применить подсказку из
````
user: root
USE eager loading detected
  Bus::HABTM_Services => [:service]
  Add to your query: .includes([:service])
Call stack
  /var/www/schedule_app/app/views/trips/_trip.html.erb:9:in `_app_views_trips__trip_html_erb___2552659478807376598_47345913761100'
  /var/www/schedule_app/app/views/trips/index.html.erb:8:in `_app_views_trips_index_html_erb__2240206535625781100_47345814716480
  ````
