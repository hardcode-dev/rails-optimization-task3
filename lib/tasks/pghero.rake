desc 'Очистка запросов в pg_hero'
task :empty_pghero_query_stats => :environment do
  # puts ActiveRecord::Base.connection.execute('delete from pg_statements').inspect
  puts ActiveRecord::Base.connection.execute('delete from pghero_query_stats').inspect
end