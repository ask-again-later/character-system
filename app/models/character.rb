class Character < ApplicationRecord
	belongs_to :user
	has_many :questionnaire_answers
end
