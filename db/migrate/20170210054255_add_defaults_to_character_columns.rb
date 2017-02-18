class AddDefaultsToCharacterColumns < ActiveRecord::Migration[5.0]
  def change
    change_column :characters, :artsy, :integer, default: 0
    change_column :characters, :athletics, :integer, default: 0
    change_column :characters, :bureaucracy, :integer, default: 0
    change_column :characters, :drive, :integer, default: 0
    change_column :characters, :fight, :integer, default: 0
    change_column :characters, :guns, :integer, default: 0
    change_column :characters, :handy, :integer, default: 0
    change_column :characters, :stealth, :integer, default: 0
    change_column :characters, :outdoorsy, :integer, default: 0
    change_column :characters, :theft, :integer, default: 0
    change_column :characters, :empathy, :integer, default: 0
    change_column :characters, :persuasion, :integer, default: 0
    change_column :characters, :intimidation, :integer, default: 0
    change_column :characters, :investigation, :integer, default: 0
    change_column :characters, :computers, :integer, default: 0
    change_column :characters, :academics, :integer, default: 0
    change_column :characters, :local_lore, :integer, default: 0
    change_column :characters, :engineering, :integer, default: 0
    change_column :characters, :law, :integer, default: 0
    change_column :characters, :science, :integer, default: 0
    change_column :characters, :medicine, :integer, default: 0
    change_column :characters, :religion, :integer, default: 0
    change_column :characters, :lies, :integer, default: 0
    change_column :characters, :willpower, :integer, default: 6
    change_column :characters, :initiative, :integer, default: 2
    change_column :characters, :defense, :integer, default: 2
    change_column :characters, :speed, :integer, default: 6
    change_column :characters, :stability, :integer, default: 7
    change_column :characters, :public_blurb, :text, default: ""
  end
end
