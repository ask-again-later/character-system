class CreateQuestionnaireItems < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_items do |t|
      t.string  :question, null: false
      t.integer :order

      t.timestamps
    end
  end
end
