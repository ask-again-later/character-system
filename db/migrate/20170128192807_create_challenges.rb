class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
    	t.string :title
    	t.text :description
    	t.boolean :is_creature_challenge
      t.timestamps
    end
  end
end
