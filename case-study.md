# ДЗ 3
1. Проблема из bullet 
    USE eager loading detected
        Trip => [:bus]
        Add to your query: .includes([:bus])
 - решил добавить промежуточную модель BusesService и заменить has_and_belongs_to_many, на has_many through
 - варнинг в bullet пропал, скорость загрузки страницы уменьшилась с ~600 ms до ~ 180 ms
2.