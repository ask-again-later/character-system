class CreateRituals < ActiveRecord::Migration[5.0]
  def change
    create_table :rituals do |t|
      t.string :principle
      t.string :trappings
      t.string :focus
      t.text :effect
      t.string :duration
    end
  end
end
