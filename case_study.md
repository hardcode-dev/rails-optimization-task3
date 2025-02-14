

Изначально:

15 сек

Переписала trips на import:

small.json - 18 сек

не пошло - откатила

---------------
Переписала services на upsert и добавила уникальный индекс на name

```ruby
service_names = trip['bus']['services'].map { |name| { name: name } }
service_ids = Service.upsert_all(service_names, unique_by: :name)

bus = Bus.find_or_create_by(number: trip['bus']['number'])
bus.update(model: trip['bus']['model'], service_ids: service_ids.rows.flatten)
```

Теперь на small - 6 сек
-----------------
Теперь автобусы, добавим уникальный индекс:
