class ChangeTrueSelfIdToInt < ActiveRecord::Migration[5.0]
  def change
    remove_column :characters, :true_self_id
    add_column :characters, :true_self_id, :integer, default: 0, null: false
  end
end
