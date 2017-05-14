class AddCharactersRitualsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :characters_rituals do |t|
      t.integer :character_id
      t.integer :ritual_id
      t.timestamps
    end
  end
end
