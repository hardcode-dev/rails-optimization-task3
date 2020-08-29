module Dbclear
  extend ActiveSupport::Concern

  included do
    def self.clear
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name}")
    end
  end
end
