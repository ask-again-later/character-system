class ChangeRequiresSpecificationToBoolean < ActiveRecord::Migration[5.0]
  def change
    remove_column :advantages, :requires_specification
  end
end
