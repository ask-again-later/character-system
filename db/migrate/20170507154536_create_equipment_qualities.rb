class CreateEquipmentQualities < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment_qualities do |t|
      t.string :name, null: false
      t.integer :equipment_type, null: false
      t.string :description
    end
  end
end
