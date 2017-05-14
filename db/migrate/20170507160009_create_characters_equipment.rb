class CreateCharactersEquipment < ActiveRecord::Migration[5.0]
  def change
    create_table :characters_equipment do |t|
      t.integer :character_id
      t.integer :equipment_id
    end
  end
end
