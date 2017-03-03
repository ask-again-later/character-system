class QuestionnaireAnswer < ApplicationRecord
	belongs_to :character
	belongs_to :questionnaire_item

	validates :questionnaire_item, presence: true
	validates :character, 				 presence: true
	validates :answer, 						 presence: true
end
