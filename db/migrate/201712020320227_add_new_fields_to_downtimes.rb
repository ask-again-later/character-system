class AddNewFieldsToDowntimes < ActiveRecord::Migration[5.0]
  def change
    add_column :downtime_actions, :goal, :string, default: ''
    add_column :downtime_actions, :notes, :string, default: ''
  end
end
