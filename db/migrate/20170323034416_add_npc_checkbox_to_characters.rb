class AddNpcCheckboxToCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :is_npc, :boolean, default: false
  end
end
