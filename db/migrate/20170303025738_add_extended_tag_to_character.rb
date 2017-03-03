class AddExtendedTagToCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :use_extended, :boolean, default: false
  end
end
