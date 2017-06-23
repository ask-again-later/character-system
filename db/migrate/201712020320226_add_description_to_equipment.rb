class AddDescriptionToEquipment < ActiveRecord::Migration[5.0]
  def change
    add_column :equipment, :description, :text, default: ""
  end
end
