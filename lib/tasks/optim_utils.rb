task :reload_json, [:file_name] => :environment do |_task, args|
  start_time = Time.now
  %w[City Bus Service Trip].each { |model| model.classify.constantize.delete_all }
  puts "Cleared tables #{Time.now - start_time} sec"
  increment = 0

  File.open(args.file_name) do |ff|
    nesting = 0
    str = +""

    while !ff.eof?
      ch = ff.read(1) # читаем по одному символу
      case
      when ch == '{' # начинается объект, повышается вложенность
        nesting += 1
        str << ch
      when ch == '}' # заканчивается объект, понижается вложенность
        nesting -= 1
        str << ch
        if nesting == 0 # если закончился объкет уровня trip, парсим и импортируем его
          trip = Oj.load(str)
          # my_import(trip)
          # puts trip
          ImportService.new(trip).perform
          increment += 1
          str = +""
        end
      when nesting >= 1
        str << ch
      end
    end
  end
  puts "#{increment} records"
  puts "#{Time.now - start_time} sec"
end
