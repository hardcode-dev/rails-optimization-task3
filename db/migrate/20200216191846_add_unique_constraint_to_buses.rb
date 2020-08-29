class AddUniqueConstraintToBuses < ActiveRecord::Migration[5.2]
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE buses
        ADD CONSTRAINT for_upsert UNIQUE (number);
    SQL
  end

  def down
    ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE buses
        DROP CONSTRAINT for_upsert;
    SQL
  end
end
