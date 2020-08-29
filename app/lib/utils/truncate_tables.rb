module Utils
  class TruncateTables
    def call(tables:)
      tables.each do |table|
        ActiveRecord::Base.connection.execute("truncate table #{table};")
      end
    end
  end
end
