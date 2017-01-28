class ChangeTrueSelfIdToInteger < ActiveRecord::Migration[5.0]
  def change
  	change_column :characters, :true_self_id, :string
  end
end
