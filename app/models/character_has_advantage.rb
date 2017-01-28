class CharacterHasAdvantage < ApplicationRecord
	belongs_to :advantage
	belongs_to :character
end
