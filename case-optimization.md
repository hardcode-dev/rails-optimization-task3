# Оптимизация Rails приложения
Во время работы приложения было выявлено ряд проблем.
1.  Загрузка данных в базу через `rake reload_json[fixtures/large.json]` происходит очень медленно
2.  При отображении страницы расписаний наблюдается падение скорости отдачи страницы пропорционально размеру отдаваемых данных. 

## Проблема №1
##### Импорт json данных в БД. Бюджет не более 1 минуты при загрузки файла `fixtures/large.json`

#### Снимаем метрику

*использовался rspec benchmark. Учитываем, что цифры будут не много завышаны на запуск теста*

| File   |    Finished in |
|:------:|:--------------:|
| small  |       8.49 sec | 
| medium | 1 min 9.43 sec | 
| large  |    не дождался | 

#### Решение
Для импорта данных воспользуемся библиотекой `activerecord-import`

Что бы понять что вообще происходит нарисовал ERD
![erd](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/ERD.png)

####Выявил ряд проблем
* Таблица services лишняя. Запись/обновление/удаление производиться не будет. Значит смело можно удалять таблицу и модель. А данные засунуть как минимум в массив. Тем более их мало. А в таблице будем Bus будем хранить массив индексов сервисов. Соответственно львинная доля запросов уйдет сама. Минус этого усложниться логика в представлениях. И мб проще и быстрее в массиве сразу хранить строки. Пока не знаю. Тесты покажут.

* В модели Bus колонка model имее так же статические данные. Изменим тип данных на int. И воспользуемся макросом Enum.
![erd](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/ERD2.png)

Так же заменил стандартный json на oj.
После того как таск был переписан с помощью activerecord-import. Результаты теста стали такие

####Результаты

| File   |    Finished in |
|:------:|:--------------:|
| small  |       1.42 sec | 
| medium |      11.74 sec | 
| large  |    2 min 5 sec | 

По крайней мере я дождался. В бюджет не уложился. Оптимизируем дальше.

## Проблема №2
В коде совершил ошибку. При инициализации объектов trip для каждого объекта не сколько раз отправлял запросы в БД на получения объектов.

*отчет stackprof*

`210	54.26%	2	0.52%	ActiveRecord::Core::ClassMethods#find_by`

#### Решение

Одним запросом закешировать нужные данные. Upsert + active-record import пока не осилил. В Rails 6 это будет бомба фича!

В бюджет уложился. Большой был импортирован за 41.97 секунды.

## Оптимизация приложения
Естественно всё падает. 
![fail](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/no_service_no_gain.png)

После запуска приложения первым, что у нас упало это отсутствие класс Service.
Фиксим паршелы.

Удалил паршл _service.html.erb. А в _services.html.erb вывел показ услуг автобуса. 
И вообще меньше паршлов быстрей отдача страницы. Да и хелперы будут актуальней если верстки мало.

Страница запустилась. Пора собирать метрику.
![it`s working](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/its_ok.png)


- [x] `rack-mini-profiler` -e production

Отдача страницы за 1,5 секунды

 ![rmp](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/mrp.png)

- [x] `rails panel`

 ![rails panel](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/r_panel.png)
 
- [x] `bullet` -e development
Подключаем депортамент советчиков при работе с БД. 

 ![bullet](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/bullet.png)
- [ ] `explain` запросов Пока PGHero не смог.

----
Напишем тесты чтобы быт увереным что ни чего не сломал. 
Написал unit test на контроллер и acceptance test

####Начинаем поиск проблем

### Проблема 1
N + 1 При получении всех автобусов в маршруте. На это нам указывает все и bullet намекает использовать includes 
После не большоего апдейта в контроллере время загрузки страницы уменьшилась на 1 секунду 
`Trip.preload(:bus).where(from: @from, to: @to).order(:start_time)`
Воспользовался preload так как нет выборки по соединительной таблице.

####Результат
~ 560 ms - 650ms

 
###Собираем метрику
* rack-mini-profile
 ![rmp](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/includes.png)
  ![rmp](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/rmp-1.png)
  
* Советчик bullet потерял хрустальный шар =(
* rails panel

   ![rp](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/rp-1.png)
   
 ### Проблема 2
 
 Ужасно долгий рендеринг паршлов. (Так как они загружаются в цикле колекций)
    ![renders](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/renders.png)
        ![renders](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/rp-2.png)
        ![renders](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/rp-3.png)
        
* Удалил паршл с разделительной полосой и сервисы. Оставил один паршл для Рейсов.
       
* В представлении отправляется лишний запрос для получения кол-ва рейсов. count заменяем на size

`<%= "В расписании #{@trips.size} рейсов" %>`

* Кешируем саму коллекцию.

В дев окружении открытие странице занело менее 3х секунд
![renders](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/rmp-3.png)

####Результат
        
![renders](https://raw.githubusercontent.com/VidgarVii/rails-optimization-2-task3/optimize/fixtures/images/rmp-2.png)

