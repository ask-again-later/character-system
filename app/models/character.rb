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

  after_create :calculate_derived_stats

	def get_status
		return STATUS[self.status]
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
