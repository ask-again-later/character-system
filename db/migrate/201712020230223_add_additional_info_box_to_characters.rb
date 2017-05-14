class AddAdditionalInfoBoxToCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :additional_info, :text, default: ""
  end
end
