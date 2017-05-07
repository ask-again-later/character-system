class CreateEquipmentsEquipmentQualities < ActiveRecord::Migration[5.0]
  def change
    create_table :equipments_equipment_qualities do |t|
      t.integer :equipment_id
      t.integer :equipment_quality_id
    end
  end
end
