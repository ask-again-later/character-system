class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name,                   default: ""
      t.string :pronouns,               default: ""
      t.integer :status,                default: 0
      t.text :public_blurb,             default: ""
      t.references :user,               index: true, foreign_key: true, null: false
      t.references :true_self,          index: true, foreign_key: true
      t.integer :intelligence,          default: 1
      t.integer :wits,                  default: 1
      t.integer :resolve,               default: 1,
      t.integer :strength,              default: 1
      t.integer :dexterity,             default: 1
      t.integer :stamina,               default: 1
      t.integer :presence,              default: 1
      t.integer :manipulation,          default: 1
      t.integer :composure,             default: 1
      t.integer :handy,                 default: 0
      t.integer :religion,              default: 0
      t.integer :bureaucracy,           default: 0
      t.integer :athletics,             default: 0
      t.integer :fight,                 default: 0
      t.integer :drive,                 default: 0
      t.integer :guns,                  default: 0
      t.integer :theft,                 default: 0
      t.integer :stealth,               default: 0
      t.integer :outdoorsy,             default: 0
      t.integer :empathy,               default: 0
      t.integer :artsy,                 default: 0
      t.integer :intimidation,          default: 0
      t.integer :persuasion,            default: 0
      t.integer :lies,                  default: 0
      t.integer :academics,             default: 0
      t.integer :investigation,         default: 0
      t.integer :medicine,              default: 0
      t.integer :local_lore,            default: 0
      t.integer :law,                   default: 0
      t.integer :science,               default: 0
      t.integer :computers,             default: 0
      t.integer :engineering,           default: 0
      t.integer :health,                default: 2
      t.integer :willpower,             default: 6
      t.integer :stability,             default: 7
      t.integer :defense,               default: 2
      t.integer :speed,                 default: 6
      t.integer :initiative,            default: 2
      t.boolean :use_extended,          default: false

      t.timestamps
    end
  end
end
