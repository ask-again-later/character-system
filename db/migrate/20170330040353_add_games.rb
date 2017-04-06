class AddGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :title
      t.boolean :downtimes_open, default: false
      t.boolean :downtimes_visible, default: false

      t.timestamps
    end
  end
end
