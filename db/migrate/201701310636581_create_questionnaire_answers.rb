class CreateQuestionnaireAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_answers do |t|
      t.references :questionnaire_item, index: true, foreign_key: true, null: false
      t.references :character,          index: true, foreign_key: true, null: false
      t.text       :answer,             null: false

      t.timestamps
    end
  end
end
