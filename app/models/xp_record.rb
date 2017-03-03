class XpRecord < ApplicationRecord
	belongs_to :character

	validates :character, presence: true
	validates :amount,    presence: true
end
