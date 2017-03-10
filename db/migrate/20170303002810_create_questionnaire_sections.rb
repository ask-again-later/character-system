class CreateQuestionnaireSections < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_sections do |t|
      t.string :title
      t.text :instructions
      t.integer :order, default: 0
      t.timestamps
    end
  end
end
