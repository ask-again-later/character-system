class CreateQuestionnaireAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_answers do |t|
      t.integer :questionnaire_item_id
      t.integer :character_id
      t.text :answer

      t.timestamps
    end
  end
end
