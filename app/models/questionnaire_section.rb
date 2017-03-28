class QuestionnaireSection < ApplicationRecord
  has_many :questionnaire_items, dependent: :destroy

  accepts_nested_attributes_for :questionnaire_items, allow_destroy: true
end
