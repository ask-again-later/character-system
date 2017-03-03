class SetALotOfStuffToNotNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :characters, :name, true, default: 'Unnamed Character'
    change_column_null :characters, :pronouns, true, default: ""
    change_column_null :characters, :status, true, default: 0
    change_column_null :characters, :true_self_id, true, default: 1
    change_column_null :characters, :intelligence, true, default: 1
    change_column_null :characters, :wits, true, default: 1
    change_column_null :characters, :resolve, true, default: 1
    change_column_null :characters, :strength, true, default: 1
    change_column_null :characters, :dexterity, true, default: 1
    change_column_null :characters, :stamina, true, default: 1
    change_column_null :characters, :presence, true, default: 1
    change_column_null :characters, :manipulation, true, default: 1
    change_column_null :characters, :composure, true, default: 1
  end
end
