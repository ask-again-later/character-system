class AddExperienceExpenditures < ActiveRecord::Migration[5.0]
  def change
    create_table :xp_expenditures do |t|
      t.integer :character_id, null: false
      t.string :diff
      t.integer :amount, default: 0
      t.boolean :is_approved, default: false
      t.timestamps
    end
  end
end
