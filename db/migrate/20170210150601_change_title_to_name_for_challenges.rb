class ChangeTitleToNameForChallenges < ActiveRecord::Migration[5.0]
  def change
    rename_column :challenges, :title, :name
  end
end
