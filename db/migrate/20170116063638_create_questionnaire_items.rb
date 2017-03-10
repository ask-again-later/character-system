class CreateQuestionnaireItems < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_items do |t|
      t.string  :question, null: false
      t.integer :order
      t.integer :questionnaire_section_id, default: 1
      t.boolean :required, default: true
      t.boolean :extended, default: false

      t.timestamps
    end
  end
end
