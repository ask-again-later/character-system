class AddNpcMotivationColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :motivation, :text, default: ""
  end
end
