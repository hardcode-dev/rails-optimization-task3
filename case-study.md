# Case-study оптимизации



## Проблема №1
Импорт данных на файле large.json занимает больше 10минут, нужно ускорить импорт, чтобы он проходил в пределах минуты.

- Метрика - время выполнения импорта 

## Подготовка
1. Логику импорта вынес в класс и написал тест

## Feedback-Loop
1. Профилирование
2. Изменение кода
3. Тесты
4. Постоение отчета

## Инструменты
- benchmark
- pg-hero
- stackprof


### Предварительный анализ
![before](massif-visualizer/before.png)

В пике программа потребляет 409мб, что не укладывается в наш бюджет.

### Ваша находка №1

- Парсинг даты

```
data[:dates].map {|d| Date.parse(d)}.sort.reverse.map { |d| d.iso8601 }
```
- Убираем парсинг даты
```
data[:dates].sort.reverse
```
- потребление в пике памяти снизилось до 389мб, но характер роста остался прежним
![before](massif-visualizer/iteration_1.png)
  
- исправленная проблема перестала быть главной точкой роста(memory profiler)

### Ваша находка №2

- Общий список браузером, на большом объеме вставка в массив, сортировка и получение уникальных элементов
```
allBrowsers = []

allBrowsers << session['browser'] 

allBrowsers = allBrowsers.sort.uniq

oj.push_value(allBrowsers.count, 'uniqueBrowsersCount')
oj.push_value(allBrowsers.join(','), 'allBrowsers')
```
- Заменим Array на SortedSet
```
all_browsers = SortedSet.new

all_browsers.add(session['browser'])

allBrowsers = ''
firstIteration = true
all_browsers.each do |browser|
  if firstIteration
    allBrowsers = browser.dup
  else
    allBrowsers << ','
    allBrowsers << browser.dup
  end
  firstIteration = false
end

oj.push_value(all_browsers.count, 'uniqueBrowsersCount')
oj.push_value(allBrowsers, 'allBrowsers')
 
```
- потребление в пике памяти снизилось до 40мб, исчез роста памяти в зависимости от количества данных   
  ![before](massif-visualizer/iteration_2.png)

- исправленная проблема перестала быть главной точкой роста и мы уложились в бюдет

## Результаты
Удалось улучшить метрику системы и уложиться в заданный бюджет. Программа теперь не должна потреблять больше 70Мб памяти при обработке файла data_large в течение всей своей работы

## Защита от регрессии производительности
Для защиты от потери достигнутого прогресса при дальнейших изменениях программы был написын тест:

```
it 'allocates less than 70MB in memory' do
  expect { work('data_large.txt') }.to perform_allocation(70_000_00).bytes
end
```

