class CreateAdvantages < ActiveRecord::Migration[5.0]
  def change
    create_table :advantages do |t|
    	t.string :name
    	t.text :description
    	t.integer :rating
    	t.string :specification
      t.timestamps
    end
  end
end
