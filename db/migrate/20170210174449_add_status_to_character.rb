class AddStatusToCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :status, :integer, default: 0
  end
end
