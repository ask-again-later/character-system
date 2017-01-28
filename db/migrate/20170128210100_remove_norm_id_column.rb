class RemoveNormIdColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :characters, :norm_id
  end
end
