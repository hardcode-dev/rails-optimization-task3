require 'ruby-prof'

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  profile = RubyProf.profile do
    ImportData.new(JSON.parse(File.read(args.file_name), symbolize_names: true)).exec
  end


  printer1 = RubyProf::GraphHtmlPrinter.new(result)
  printer1.print(File.open("ruby_prof_reports/graph.html", "w+"))

  printer = RubyProf::FlatPrinter.new(result)
  printer.print(STDOUT)
end
#     data = JSON.parse(File.read('spec/data.json'), symbolize_names: true)
