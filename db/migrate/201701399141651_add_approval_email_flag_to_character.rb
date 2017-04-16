class AddApprovalEmailFlagToCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :approval_sent, :boolean, default: false
    add_column :characters, :is_npc, :boolean, default: false
  end
end
