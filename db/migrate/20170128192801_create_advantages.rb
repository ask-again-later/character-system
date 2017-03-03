class CreateAdvantages < ActiveRecord::Migration[5.0]
  def change
    create_table :advantages do |t|
    	t.string  :name,                   null: false
    	t.text    :description,            null: false
    	t.string  :allowed_ratings,        default: ""
    	t.boolean :requires_specification, default: false
      t.string  :prerequisites,          default: ""
      t.timestamps
    end
  end
end
