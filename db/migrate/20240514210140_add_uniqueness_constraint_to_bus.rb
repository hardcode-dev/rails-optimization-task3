class AddUniquenessConstraintToBus < ActiveRecord::Migration[5.2]
  def change
    add_index :buses, [:number, :model], unique: true
  end
end
