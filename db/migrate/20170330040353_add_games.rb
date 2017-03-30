class AddGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :title
      t.boolean :downtimes_visible
      
      t.timestamps
    end
  end
end
