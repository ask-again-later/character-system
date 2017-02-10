class AddInitiativeToCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :initiative, :integer, default: 0
  end
end
