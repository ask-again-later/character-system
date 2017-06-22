class AddColumnsForSecretNpCs < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :is_secret, :boolean, default: false
  end
end
