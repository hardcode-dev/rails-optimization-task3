# Case-study оптимизации

### Добавил необходимые гемы для профилирования:
- bullet
- rack-mini-profiler
- pghero
- fasterer

### Находка №1
- `gem bullet` обнаружил N + 1: `Add to your query: .includes([:bus])`
- добавил `preload(bus: :services)`
- исправленна проблема N + 1
- скорость отображения страницы изменилась с `1487ms` до `205ms`

### Находка №2
- загрузил файл `medium.json`
- посмотрел rails model dependency diagram
- добавил модель `BusesService`
- скорость отображения страницы изменилась с `1473ms` до `705ms`

