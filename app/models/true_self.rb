class TrueSelf < ApplicationRecord
	has_many :characters

	validates :name, presence: true
end
