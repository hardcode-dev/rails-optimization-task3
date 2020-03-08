class ChangeBusPrimaryKey < ActiveRecord::Migration[5.2]
  def up
    remove_column :buses, :id
    execute 'ALTER TABLE buses ADD CONSTRAINT buses_pkey PRIMARY KEY ("number",model);'
    add_index :buses, [:number, :model], unique: true
  end

  def down
    execute 'ALTER TABLE buses DROP CONSTRAINT buses_pkey;'
    add_column :buses, :id, :primary_key

    remove_index :buses, [:number, :model]
  end
end
