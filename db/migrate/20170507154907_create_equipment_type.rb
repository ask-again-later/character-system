class CreateEquipmentType < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment_types do |t|
      t.string :name, null: false
    end
  end
end
