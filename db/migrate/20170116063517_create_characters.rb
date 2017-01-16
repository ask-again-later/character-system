class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :user_id
      t.integer :norm_id
      t.string :true_self
      t.integer :stability
      t.integer :handy
      t.integer :religion
      t.integer :bureaucracy
      t.integer :athletics
      t.integer :fight
      t.integer :drive
      t.integer :guns
      t.integer :theft
      t.integer :stealth
      t.integer :outdoorsy
      t.integer :empathy
      t.integer :artsy
      t.integer :intimidation
      t.integer :persuasion
      t.integer :lies
      t.integer :academics
      t.integer :investigation
      t.integer :medicine
      t.integer :local_lore
      t.integer :law
      t.integer :science
      t.integer :computers
      t.integer :engineering
      t.text :public_blurb
      t.integer :willpower
      t.integer :defense
      t.integer :armor
      t.integer :speed
      t.integer :size

      t.timestamps
    end
  end
end
