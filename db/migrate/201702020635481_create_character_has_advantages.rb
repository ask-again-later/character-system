class CreateCharacterHasAdvantages < ActiveRecord::Migration[5.0]
  def change
    create_table :character_has_advantages do |t|
      t.references :character, index: true, foreign_key: true, null: false
      t.references :advantage, index: true, foreign_key: true, null: false
      t.integer    :rating,    null: false
      t.string     :specification

      t.timestamps
    end
  end
end
