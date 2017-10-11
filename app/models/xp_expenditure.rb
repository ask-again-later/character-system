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
				count += minus*3
			end
		end

		skills.each do |sk|
			unless diff[sk].nil?
				minus = diff[sk][1] - diff[sk][0]
				count += minus*2
			end
		end

		training.each do |tr|
			unless diff[tr].nil?
				minus = diff[tr][1] - diff[tr][0]
				count += minus*2
			end
		end

		if diff['character_has_advantages'].present?
			advantages_old = diff['character_has_advantages'][0]
			advantages_new = diff['character_has_advantages'][1]

			advantages_removed = advantages_old.select{|ao| advantages_new.index{|an| an['id'] == ao['id']}.nil?}
			advantages_updated = advantages_old.reject{|ao| ab = advantages_new.bsearch{|an| an['id'] == ao['id']}; ab.present? ? ab['rating'] == ao['rating'] : true}
			advantages_added = advantages_new.select{|an| an['id'].nil?}

			advantages_updated.each do |au|
				oldval = advantages_old.bsearch{|ao| ao['id'] == au['id']}
				newval = advantages_new.bsearch{|an| an['id'] == au['id']}
				if oldval.nil?
					diffval = newval['rating']
				else
					diffval = newval['rating'] - oldval['rating']
				end
				count += diffval
			end

			advantages_removed.each do |ar|
				count -= ar['rating']
			end

			advantages_added.each do |aa|
				count += aa['rating']
			end
		end

		self.amount = count
  end
end
