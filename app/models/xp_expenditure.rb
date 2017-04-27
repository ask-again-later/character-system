class XpExpenditure < ApplicationRecord
	belongs_to :character

	validates :character, presence: true
	validates :amount,    presence: true

  before_save :calc_amount

  private

  def calc_amount
    diff = JSON.parse(self.diff)
		count = 0
		attributes = ['intelligence', 'wits', 'resolve', 'strength', 'dexterity', 'stamina', 'presence', 'manipuation', 'composure']
		skills = ['artsy', 'athletics', 'bureaucracy', 'drive', 'empathy', 'fight', 'guns', 'handy', 'intimidation', 'lies', 'outdoorsy', 'persuasion', 'religion', 'stealth', 'theft']
		training = ['academics', 'computers', 'engineering', 'investigation', 'law', 'local_lore', 'medicine', 'science']
		attributes.each do |at|
			unless diff[at].nil?
				minus = diff[at][1] - diff[at][0]
				count += minus*4
			end
		end

		skills.each do |sk|
			unless diff[sk].nil?
				minus = diff[sk][1] - diff[sk][0]
				count += minus*1
			end
		end

		training.each do |tr|
			unless diff[tr].nil?
				minus = diff[tr][1] - diff[tr][0]
				count += minus*2
			end
		end

		self.amount = count
  end
end
