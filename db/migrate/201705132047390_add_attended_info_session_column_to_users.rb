class AddAttendedInfoSessionColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :attended_info_session, :boolean, default: false
  end
end
