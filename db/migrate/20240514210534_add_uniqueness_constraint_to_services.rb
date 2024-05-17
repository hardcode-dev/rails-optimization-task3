class AddUniquenessConstraintToServices < ActiveRecord::Migration[5.2]
  def change
    add_index :services, :name, unique: true
  end
end
