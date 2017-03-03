class Challenge < ApplicationRecord
	has_many :character_has_challenges
	has_many :characters, through: :character_has_challenges

	validates :name, 				presence: true, uniqueness: true
	validates :description, presence: true
end
