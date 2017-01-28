class Advantage < ApplicationRecord
	has_many :character_has_advantages
	has_many :characters, through: :character_has_advantages
end
