require 'active_record'
require 'benchmark'
require 'csv'

def get_rss
  `ps -o rss= -p #{Process.pid}`.to_i
end

COLUMN_LENGTH = 100
COLUMN_SIZE = 10
RECORD_SIZE = 100_000
BATCH_SIZE = 500

columns = Array.new(COLUMN_SIZE) { |i| ('a'.ord + (i % 26)).chr * COLUMN_LENGTH }
records = Array.new(RECORD_SIZE, columns)

# $ docker run --rm -p 5432:5432 -e POSTGRES_PASSWORD=password -d postgres:9.6
# $ psql -h localhost -U postgres -d postgres
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  host: 'db-postgresql',
  database: 'postgres',
  username: 'rails',
  password: 'password',
)

conn = ActiveRecord::Base.connection
raw_conn = ActiveRecord::Base.connection.raw_connection

%i(
  benchmark_copy_format_text_1
  benchmark_copy_format_text_2
  benchmark_copy_format_csv_1
  benchmark_copy_format_csv_2
  benchmark_bulk_insert_1
  benchmark_bulk_insert_2
).each do |table_name|
  conn.create_table table_name, force: true, id: false do |t|
    COLUMN_SIZE.times { |i| t.string "col#{i}" }
  end
end

rss_log = []

Benchmark.bm(35) do |x|
  x.report('COPY TEXT at once') do
    get_rss.tap do |rss|
      encoder = PG::TextEncoder::CopyRow.new
      raw_conn.copy_data('copy benchmark_copy_format_text_1 from stdin', encoder) do
        records.each do |row|
          raw_conn.put_copy_data(row)
        end
      end
      rss_log << get_rss - rss
    end
  end

  x.report('COPY TEXT in batch') do
    get_rss.tap do |rss|
      encoder = PG::TextEncoder::CopyRow.new
      records.each_slice(BATCH_SIZE) do |rows|
        raw_conn.copy_data('copy benchmark_copy_format_text_2 from stdin', encoder) do
          rows.each do |r|
            raw_conn.put_copy_data(r)
          end
        end
      end
      rss_log << get_rss - rss
    end
  end

  x.report('COPY CSV with CSV.generate_line') do
    get_rss.tap do |rss|
      records.each_slice(BATCH_SIZE) do |rows|
        raw_conn.copy_data('copy benchmark_copy_format_csv_1 from stdin with (format csv)') do
          rows.each do |row|
            raw_conn.put_copy_data(CSV.generate_line(row, force_quotes: true))
          end
        end
      end
      rss_log << get_rss - rss
    end
  end

  x.report('COPY CSV with Array#join') do
    get_rss.tap do |rss|
      records.each_slice(BATCH_SIZE) do |rows|
        raw_conn.copy_data('copy benchmark_copy_format_csv_2 from stdin with (format csv)') do
          rows.each do |row|
            raw_conn.put_copy_data(row.map { |col| "\"#{col}\"" }.join(',') + "\n")
          end
        end
      end
      rss_log << get_rss - rss
    end
  end

  x.report('BULK INSERT with generate SQLs') do
    get_rss.tap do |rss|
      records.each_slice(BATCH_SIZE) do |rows|
        sql = 'insert into benchmark_bulk_insert_1 values '
        sql << rows.map { |row| '(' + row.map { |col| "'#{col}'" }.join(',') + ')'  }.join(',')
        conn.execute(sql)
      end
      rss_log << get_rss - rss
    end
  end

  sqls = []
  records.each_slice(BATCH_SIZE) do |rows|
    sql = 'insert into benchmark_bulk_insert_2 values '
    sql << rows.map { |row| '(' + row.map { |col| "'#{col}'" }.join(',') + ')'  }.join(',')
    sqls << sql
  end
  x.report('BULK INSERT without generate SQLs') do
    get_rss.tap do |rss|
      sqls.each do |sql|
        conn.execute(sql)
      end
      rss_log << get_rss - rss
    end
  end
end


puts "\n[RSS]\n"
puts rss_log.map { |rss| format('+ %5d', rss) }.join("\n")
