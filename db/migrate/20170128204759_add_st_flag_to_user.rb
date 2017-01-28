class AddStFlagToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :is_storyteller, :boolean, default: false
  end
end
