class AddAttributesToCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :intelligence, :integer, default: 1, null: false
    add_column :characters, :wits, :integer, default: 1, null: false
    add_column :characters, :resolve, :integer, default: 1, null: false
    add_column :characters, :strength, :integer, default: 1, null: false
    add_column :characters, :dexterity, :integer, default: 1, null: false
    add_column :characters, :stamina, :integer, default: 1, null: false
    add_column :characters, :presence, :integer, default: 1, null: false
    add_column :characters, :manipulation, :integer, default: 1, null: false
    add_column :characters, :composure, :integer, default: 1, null: false
  end
end
