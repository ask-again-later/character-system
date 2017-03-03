class CreateQuestionnaireSections < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_sections do |t|
      t.string :title
      t.text :instructions
      t.timestamps
    end

    add_column :questionnaire_items, :questionnaire_section_id, :integer
  end
end
