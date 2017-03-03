class QuestionnaireItem < ApplicationRecord
	has_many :questionnaire_answers

	validates :question, presence: true
end
