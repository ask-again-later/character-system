class AddRequiredAndExtendedFieldsToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questionnaire_items, :required, :boolean, default: true
    add_column :questionnaire_items, :extended, :boolean, default: false
  end
end
