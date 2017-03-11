class AddDescriptionForTrueSelves < ActiveRecord::Migration[5.0]
  def change
    add_column :true_selves, :description, :text, default: ''
  end
end
