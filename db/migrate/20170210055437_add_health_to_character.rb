class AddHealthToCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :health, :integer, default: 6
  end
end
