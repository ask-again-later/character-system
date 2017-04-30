require 'active_record/diff'

class CharacterHasAdvantage < ApplicationRecord
	include ActiveRecord::Diff

	diff :exclude => [:created_at, :updated_at, :character_id, :advantage_id]
	
	belongs_to :advantage
	belongs_to :character
end
