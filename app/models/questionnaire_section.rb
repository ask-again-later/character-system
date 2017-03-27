class QuestionnaireSection < ApplicationRecord
  has_many :questionnaire_items
  
  accepts_nested_attributes_for :questionnaire_items
end
