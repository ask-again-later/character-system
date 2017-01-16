class CreateQuestionnaireItems < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_items do |t|
      t.string :question
      t.integer :order

      t.timestamps
    end
  end
end
