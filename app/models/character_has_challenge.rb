class CharacterHasChallenge < ApplicationRecord
	belongs_to :character
	belongs_to :challenge
end
