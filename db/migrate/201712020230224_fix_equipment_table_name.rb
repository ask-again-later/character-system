class FixEquipmentTableName < ActiveRecord::Migration[5.0]
  def change
    rename_table :equipments, :equipment
  end
end
