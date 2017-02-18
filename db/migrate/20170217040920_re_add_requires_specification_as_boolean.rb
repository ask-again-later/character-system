class ReAddRequiresSpecificationAsBoolean < ActiveRecord::Migration[5.0]
  def change
    add_column :advantages, :requires_specification, :boolean, default: false
  end
end
