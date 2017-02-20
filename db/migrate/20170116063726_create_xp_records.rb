class CreateXpRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :xp_records do |t|
      t.references :character, index: true, foreign_key: true, null: false
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
