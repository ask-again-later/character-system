class CharacterMailer < ActionMailer::Base
	def character_submission(character, st)
		@character = character
		@user = @character.user.name
		@st_name = st.name
		puts "sending email to #{st.email}"
		mail(
      :subject => "[AAL Character System] New character submission from #{@user}",
      :to  => st.email,
      :from => 'sts@askagainlater.com')
	end

	def character_approval(character)
		@character = character
		@user = @character.user
		puts 'character approval mailer started'
		mail(
			:subject => "[AAL Character System] Your character submission has been approved",
			:to => @user.email,
			:from => 'sts@askagainlater.com')
	end
end
