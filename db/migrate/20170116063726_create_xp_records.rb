class CreateXpRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :xp_records do |t|
      t.integer :character_id
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
