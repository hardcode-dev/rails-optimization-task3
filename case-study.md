# ДЗ 3
---Метрики---
- скорость загрузки large.json до 60 секунд
- оптимизация загрузки страницы
1. Проблема из bullet 
    USE eager loading detected
        Trip => [:bus]
        Add to your query: .includes([:bus])
 - решил добавить промежуточную модель BusesService и заменить has_and_belongs_to_many, на has_many through
 - добавил preload(bus: :services) в tips_controller
 - варнинг в bullet пропал, скорость загрузки страницы уменьшилась с ~600 ms до ~ 180 ms
 - rack-mini-profiler показал что кол-во запросов значительно уменьшилось
2. Долгая загрузка JSON
- переписал task для работы с гемом activerecord-import
- после применения activerecord-import загрузка small.json ускорилась с ~13 до ~1 секунды
- поменял стандартный JSON на gem oj
- загрузка ускорилась, но незначительно
- удалось уложиться в метрику загрузки large.json до 60 секунд (~49 сек)
3. Оптимизация загрузки страницы
- Убрал лишние паршалы
- Добавил коллекции и добавил spacer_template
- время загрузки сократилось очень значительно, до 600 ms при large.json