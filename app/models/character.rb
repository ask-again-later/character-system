require 'active_record/diff'

class Character < ApplicationRecord
	include ActiveRecord::Diff
	diff :include => [:character_has_advantages, :character_has_challenges], :exclude => [:created_at, :updated_at, :speed, :willpower, :health, :defense, :stability, :status, :initiative]
	belongs_to :user
	has_many :questionnaire_answers, dependent: :destroy
	has_many :character_has_challenges, dependent: :destroy
	has_many :challenges, through: :character_has_challenges
	has_many :character_has_advantages, dependent: :destroy
	has_many :advantages, through: :character_has_advantages
	has_many :downtime_actions
	has_many :xp_records
	has_many :xp_expenditures
	belongs_to :true_self
	has_and_belongs_to_many :rituals

	accepts_nested_attributes_for :questionnaire_answers
	accepts_nested_attributes_for :character_has_challenges, allow_destroy: true
	accepts_nested_attributes_for :character_has_advantages, allow_destroy: true
	accepts_nested_attributes_for :rituals

	validates :user, presence: true

  after_create :calculate_derived_stats

	def get_status
		return STATUS[self.status]
	end

	def current_xp
		xprecords = XpRecord.where(character_id: self.id)
		total = 0;
		xprecords.each do |xpr|
			total += xpr.amount
		end
		total
	end

	private

	STATUS = ["In Progress", "Submitted", "Active", "Inactive"]

  def calculate_derived_stats
    unless user.is_storyteller?
      initiative = dexterity + composure
      health = 5 + stamina
      willpower = 5 + resolve
      speed = 5 + strength
      defense = wits + athletics
      self.update(initiative: initiative, health: health, willpower: willpower,
                  speed: speed, defense: defense)
    end
  end
end
