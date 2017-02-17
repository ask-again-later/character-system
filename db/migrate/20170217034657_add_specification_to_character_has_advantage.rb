class AddSpecificationToCharacterHasAdvantage < ActiveRecord::Migration[5.0]
  def change
    rename_column :character_has_advantages, :description, :specification
  end
end
