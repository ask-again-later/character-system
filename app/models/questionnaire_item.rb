class QuestionnaireItem < ApplicationRecord
	has_many :questionnaire_answers
  belongs_to :questionnaire_section

	validates :question, presence: true
end
