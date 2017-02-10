class AddPronounsToCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :pronouns, :string, default: ""
  end
end
