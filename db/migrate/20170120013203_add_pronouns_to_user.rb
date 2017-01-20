class AddPronounsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pronouns, :string
  end
end
