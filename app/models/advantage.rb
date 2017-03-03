class Advantage < ApplicationRecord
	has_many :character_has_advantages
	has_many :characters, through: :character_has_advantages

	validates :name, 				presence: true, uniqueness: true
	validates :description, presence: true
end
