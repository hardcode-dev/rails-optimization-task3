class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities, id: :uuid do |t|
      t.string :name

      t.index :name, unique: true
    end
  end
end
