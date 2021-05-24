До начала всех оптимизации я установить progressbar в rake задачу импорта и замерил время выполнения 
Получилось
- small.json ~7 секунд
- medium.json ~90 секунд
- large.json ~15 минут по ETA прогресс бара

Метрика, которую будем оптимизировать – время импорта на объеме small.json
До оптимизаций – 7.30 секунд

Фидбек луп стандартный
- внесение изменений
- просмотр инструмент
- тесты зеленые

Оптимизация 1

- По отчету pghero было видно, что в топе запрос
```
SELECT "services".* FROM "services" INNER JOIN "buses_services" ON "services"."id" = "buses_services"."service_id" WHERE "buses_services"."bus_id" = $1
```
построив визуальное представление запроса видно, что 88% времени уходит на seq scan on buses_services 

- добавляю индекс на buses_services.bus_id в надежде, что теперь будет обращение исключительно к индексу
- Метрика realtime улучшилась 7.30 -> 7.0, в из Explain ушел Seq Scan и сменился на Index Scan using index_buses_services_on_bus_id on buses_services 

Оптимизация 2

- По отчету pghero на втором месте запрос

```
SELECT  $4 AS one FROM "buses" WHERE "buses"."number" = $1 AND "buses"."id" != $2 LIMIT $3
```

Analize показывает Seq Scan и Total Cost = 18.2

– Добавил индекс на поле number
- Seq Scan -> Index Scan и Total Cost стал равен 8.29. Метрика улучшилась 7.0 -> 6.54

Оптимизация 3
- По отчету pghero в топе был запрос на добавление
```
INSERT INTO "buses_services" ("bus_id", "service_id") VALUES ($1, $2) RETURNING "id"
```
Так как данных о сервисах мало, я решил провести денормализацию и перенести сервисы в json поле таблицы buses

- Время обработки small.json сократилось до 3.5 секунд


Оптимизация 4. city name index
- Топ pghero
```
SELECT  "cities".* FROM "cities" WHERE "cities"."name" = $1 LIMIT $2

```
- добавляю индекс на поле name
- Результатов эта оптимизация не дала. Время выполнения скрипта не изменилось. Explain запроса по прежнему показывал Seq Scan...

Оптимизация 5. Мемоизация городов
- в топе pghero по прежнему находится запрос 
```
SELECT  "cities".* FROM "cities" WHERE "cities"."name" = $1 LIMIT $2
```
Он вызывается больше всего за период работы скрипта

- На вкладке Space pghero я вижу что таблица cities небольшая по сравнению с остальными. Создаю массив в памяти CITIES куда буду складывать уже запрошенные из базы города. Так количество запросов к базе должно сократиться

- В результате запрос пропал из топа pghero. А время работы скрипта сократилось до 2.5 секунд

Оптимизация 6

- В топе pghero находился странный запрос
```
SELECT  $4 AS one FROM "buses" WHERE "buses"."number" = $1 AND "buses"."id" != $2 LIMIT $3
```
По сути он дублировал запрос 
```
SELECT  "buses".* FROM "buses" WHERE "buses"."number" = $1 LIMIT $2
```

- первым дело я изменил индекс по полю number на уникальный. Сходу подумал, что может быть связано с этим. Но не помогло. Затем я посмотрел в логи, в каком месте вызывается этот запрос и увидел, что он вызывается на строчке кода 
```
bus.update(model: trip['bus']['model'], services: services)
```
Пришла идея, как это оптимизировать – можно не вызывать этот лишний update, а создавать bus сразу с нужными полями
```
      bus ||= Bus.create(
        number: trip['bus']['number'],
        model: trip['bus']['model'], 
        services: services
      )
```

- В результате дополнительный запрос ушел из топа pghero. Время работы скрипта сократилась до 1.6 секунд

Оптимизация 7. activerecord-import
- По отчету pghero на втором месте стоял запрос на вставку в trips. Он занимал 39% времени
- Я решил, что настало время воспользоваться activerecord-import. Сгруппировать данные для вставки и вставлять пачкой
- Запрос ушел из топа. На малых данных время работы сократилось незначительно до 1.4 секунд
Однако, на целевом объеме large время стало уже приемлемым, приближающимся к минуте. 
При прогоне на объеме large и накапливании trips и вставкой всего объеме в конце время работы скрипта было ~80 секунд. Я добавил вставку при накапливании меньшего количества записей. При вставке по 10к записей время работы скрипта стало ~60 секунд

Оптимизация 8
Включил запись логов в postgres. Прогнал скрипт на large объеме данных. Натравил на логи pgbadger
Увидел что в топе по колличествую запросов, запрос
```
SELECT "buses".* FROM "buses" WHERE "buses"."number" = ? LIMIT ?;
```

- Решил воспользоваться техникой мемоизации для сокращения количества запросов в этом месте
```
      bus = buses[trip['bus']['number']]
      unless bus
        bus = Bus.find_by_number(trip['bus']['number'])
        bus ||= Bus.create(
          number: trip['bus']['number'],
          model: trip['bus']['model'], 
          services: services
        )
        buses[trip['bus']['number']] = bus
      end
```

- в результате SELECT ушел из топа запросов. Скрипт прогнался за 24 секунды на объеме large. Таким образом мы уложились в бюджет

Тестирование

Чтобы обезопасить систему от регресса я добавил тест на время работы скрипта на малом объеме
```
  describe "perfomance time" do
    let(:filename) { 'fixtures/small.json' }
    it 'must work less a second' do
      expect{ job.call}.to perform_under(1.5).sec
    end
  end
```
А также проверку на корректную работу скрипта
```
expect { job.call }.to change(Bus.all, :count).from(0).to(1)
  .and(change(Trip.all, :count).from(0).to(10))
  .and(change(City.all, :count).from(0).to(2))
```

Б. Отображение расписаний

Для подготовки оптимизаций я написал тест для защиты от регрессии
```
      it "renders the actual template" do
        get :index, params: {from: 'Самара', to: 'Москва'}
        expect(response.body).to match /Автобусы Самара – Москва/
        expect(response.body).to match /В расписании 5 рейсов/

        expect(response.body).to match /Отправление: 17:30/
        expect(response.body).to match /Прибытие: 18:07/
        expect(response.body).to match /В пути: 0ч. 37мин./
        expect(response.body).to match /Цена: 1р. 73коп./
        expect(response.body).to match /Автобус: Икарус №123/

        expect(response.body).to match /Сервисы в автобусе:/
        expect(response.body).to match /Туалет/
        expect(response.body).to match /WiFi/
        
      end

```

Установил rack-mini-profiles, rails-panel и включил буллет
Оптимизации решил проводить на объеме medium.json
До начала всех оптимизаций rake-mini-profiler показывал время отображения страницы ~1850ms (не холодный старт)

- Оптимизаций 1 Bus N + 1
- Сразу после установки bullet он выдавал предупреждения от N+1 и давал рекомендацию добавить в запрос includes(:bus)
- Так я и поступил, добавив прелоад автобусов для запроса за трипами
- Предупреждения bullet исчезло. Время рендера по rack-mini-profiler стало 600ms


Оптимизация 2 _service.html.erb
По Rails Panel было видно, что ускорять ActiveRecord похоже дальше уже некуда
ActiveRecord 16 ms
Rendering	495 ms
Other	7 ms

- Решил обратить внимание на ускорение рендеринга. На вкладке Rails panel было видно что много раз вызывается рендер маленького участка views/trips/_service.html.erb
Решил вынести этот кусочек в шаблон уровнем вышел.
- Общее время сократилось до ~350ms, время ренедера по Rails Panel ~340ms

Оптимизация 3 _delimeter.html.erb
- Как и в предыдущем пункте – проделал такое же упражнение для шаблона delimeter
- Вынес собержание шаблона на уровень выше и не вызываю дополнительно функцию render
- Общее время рендера сократилось до ~230ms, Rendering по Rails Panel ~180ms

Оптимизация 4 _tips.html.erb
- Как и в предыдущем пункте – проделал такое же упражнение для шаблона _tips.html.erb
- Вынес содержание шаблона на уровень выше и не вызываю дополнительно функцию render
- Общее время рендера сократилось до ~200ms, Rendering по Rails Panel ~120ms

Оптимизация 5 _services.html.erb
- Как и в предыдущем пункте – проделал такое же упражнение для шаблона _services.html.erb
- Вынес содержание шаблона на уровень выше и не вызываю дополнительно функцию render
- Общее время рендера сократилось до ~120ms, Rendering по Rails Panel ~70ms

Результат:
На объеме large.json страница рендерится 
по данным rack-mini-profiler ~1000ms 
по данным Rails Panel ~500ms

