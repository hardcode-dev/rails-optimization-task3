# Case-study оптимизации

### Находка №1
- добавил `gem bullet`
- обнаружил `Add to your query: .includes([:bus])`
- добавил `preload(bus: :services)`
- исправленная проблема N + 1
