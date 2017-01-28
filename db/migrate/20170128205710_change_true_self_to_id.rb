class ChangeTrueSelfToId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :characters, :true_self, :true_self_id
  end
end
