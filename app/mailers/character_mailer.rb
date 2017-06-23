class CharacterMailer < ActionMailer::Base
	def character_submission(character, st)
		@character = character
		@user = @character.user.name
		@st_name = st.name
		mail(
      :subject => "[AAL Character System] New character submission from #{@user}",
      :to  => st.email,
      :from => 'sts@askagainlater.com')
	end

	def character_submission_receipt(character)
		@character = character
		mail(
			:subject => "[AAL Character System] Receipt for your character submission: \"#{@character.name}\"",
			:to => @character.user.email,
			:from => 'sts@askagainlater.com'
		)
	end

	def character_approval(character)
		@character = character
		@user = @character.user
		mail(
			:subject => "[AAL Character System] Your character submission has been approved",
			:to => @user.email,
			:cc => 'sts@askagainlater.com',
			:from => 'sts@askagainlater.com')
	end

	def character_experience_expenditure(character, expenditure, st)
		@character = character
		@expenditure = expenditure
		@st_name = st.name
		mail(
			:subject => "[AAL Character System] New experience expenditure for #{@character.name}",
			:to => st.email,
			:from => 'sts@askagainlater.com'
		)
	end

	def character_expenditure_approved(character, expenditure)
		@character = character
		@expenditure = expenditure
		mail(
			:subject => "[AAL Character System] Experience expenditure for #{@character.name} approved",
			:to => @character.user.email,
			:cc => 'sts@askagainlater.com',
			:from => 'sts@askagainlater.com'
		)
	end
end
