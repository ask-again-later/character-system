class UpdateFieldNamesOnAdvantages < ActiveRecord::Migration[5.0]
  def change
    rename_column :advantages, :rating, :allowed_ratings
  end
end
