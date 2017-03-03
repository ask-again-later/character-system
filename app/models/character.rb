class Character < ApplicationRecord
	belongs_to :user
	has_many :questionnaire_answers
	has_many :character_has_challenges
	has_many :challenges, through: :character_has_challenges
	has_many :character_has_advantages
	has_many :advantages, through: :character_has_advantages
	belongs_to :true_self

	accepts_nested_attributes_for :questionnaire_answers, :character_has_challenges, :character_has_advantages

	validates :user, presence: true
end
