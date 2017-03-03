class AddOrderToQuestionnaireSections < ActiveRecord::Migration[5.0]
  def change
    add_column :questionnaire_sections, :order, :integer, default: 0
  end
end
