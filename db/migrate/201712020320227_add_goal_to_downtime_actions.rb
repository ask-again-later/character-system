class AddGoalToDowntimeActions < ActiveRecord::Migration[5.0]
  def change
    add_column :downtime_actions, :goal, :string, default: nil
  end
end
