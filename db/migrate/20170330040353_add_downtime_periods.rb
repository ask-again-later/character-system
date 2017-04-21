class AddDowntimePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :downtime_periods do |t|
      t.string :title
      t.boolean :is_active, default: false
      t.boolean :downtimes_open, default: false
      t.boolean :downtimes_visible, default: false

      t.timestamps
    end
  end
end
