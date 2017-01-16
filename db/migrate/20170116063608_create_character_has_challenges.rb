class CreateCharacterHasChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :character_has_challenges do |t|
      t.integer :character_id
      t.integer :challenge_id

      t.timestamps
    end
  end
end
