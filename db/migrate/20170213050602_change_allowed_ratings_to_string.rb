class ChangeAllowedRatingsToString < ActiveRecord::Migration[5.0]
  def change
    change_column :advantages, :allowed_ratings, :string, default: ""
    rename_column :advantages, :specification, :requires_specification
  end
end
