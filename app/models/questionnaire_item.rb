class QuestionnaireItem < ApplicationRecord
	has_many :questionnaire_answers
	belongs_to :questionnaire_section
end
