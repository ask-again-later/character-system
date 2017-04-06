class AddDowntimeActions < ActiveRecord::Migration[5.0]
  def change
    create_table :downtime_actions do |t|
      t.string :title, null: false
      t.string :assets
      t.integer :size, default: 0
      t.boolean :burn, default: false
      t.text :description, null: false
      t.boolean :is_submitted, default: false
      t.text :response
      t.integer :game_id, null: false
      t.integer :character_id, null: false
      t.timestamps
    end
  end
end
