class CreateCharacterHasAdvantages < ActiveRecord::Migration[5.0]
  def change
    create_table :character_has_advantages do |t|
      t.integer :character_id
      t.integer :advantage_id
      t.integer :rating
      t.string :description

      t.timestamps
    end
  end
end
