class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
    	t.string :name
    	t.text :description
    	t.boolean :is_creature_challenge, default: false
      t.boolean :is_custom, default: false
      t.timestamps
    end
  end
end
