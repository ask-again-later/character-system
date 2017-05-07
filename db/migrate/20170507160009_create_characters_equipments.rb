class CreateCharactersEquipments < ActiveRecord::Migration[5.0]
  def change
    create_table :characters_equipments do |t|
      t.integer :character_ids
      t.integer :equipment_id
    end
  end
end
