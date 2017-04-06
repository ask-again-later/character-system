class AddUnnaturalFieldToAdvantages < ActiveRecord::Migration[5.0]
  def change
    add_column :advantages, :is_unnatural, :boolean, default: false
  end
end
