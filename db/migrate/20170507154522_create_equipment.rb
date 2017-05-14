class CreateEquipment < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment do |t|
      t.string :name, null: false
      t.integer :size
      t.integer :durability
      t.integer :equipment_type_id, null: false
    end
  end
end
