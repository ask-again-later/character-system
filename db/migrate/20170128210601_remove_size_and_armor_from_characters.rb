class RemoveSizeAndArmorFromCharacters < ActiveRecord::Migration[5.0]
  def change
  	remove_column :characters, :size
  	remove_column :characters, :armor
  end
end
