class AddPrerequisitesToAdvantages < ActiveRecord::Migration[5.0]
  def change
    add_column :advantages, :prerequisites, :string, default: ""
  end
end
