# frozen_string_literal: true

require 'active_record'
require 'activerecord-import'

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  start = Time.now.to_i
  UploadData.call(args.file_name)
  finish = Time.now.to_i
  puts "\n== Loading time is #{finish - start} seconds =="
end
