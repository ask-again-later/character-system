class CreateTrueSelves < ActiveRecord::Migration[5.0]
  def change
    create_table :true_selves do |t|
      t.string :name

      t.timestamps
    end
  end
end
