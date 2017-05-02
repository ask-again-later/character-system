require 'active_record/diff'

class CharacterHasChallenge < ApplicationRecord
	include ActiveRecord::Diff
	diff :exclude => [:created_at, :updated_at, :character_id, :challenge_id]

	belongs_to :character
	belongs_to :challenge
end
