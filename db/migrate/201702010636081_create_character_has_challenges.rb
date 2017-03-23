class CreateCharacterHasChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :character_has_challenges do |t|
      t.references :character, index: true, foreign_key: true, null: false
      t.references :challenge, index: true, foreign_key: true, null: false
      t.string :custom_name
      t.text :custom_description

      t.timestamps
    end
  end
end
