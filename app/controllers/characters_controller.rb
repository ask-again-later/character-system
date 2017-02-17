class CharactersController < ApplicationController
	before_action :authenticate_user!

	helper_method :get_status

	ATTRIBUTES = {"Mental": ["Intelligence", "Wits", "Resolve"], "Physical": ["Strength", "Dexterity", "Stamina"], "Social": ["Presence", "Manipulation", "Composure"]}
	SKILLS_TRAINING = {"Skills": ["Artsy", "Athletics", "Bureaucracy", "Drive", "Empathy", "Fight", "Guns", "Handy", "Intimidation", "Lies", "Outdoorsy", "Persuasion", "Religion", "Stealth", "Theft"], "Special Training": ["Academics", "Computers", "Engineering", "Investigation", "Law", "Local Lore", "Medicine", "Science"]}
	STATUS_ENUM = ["Editing", "Submitted", "Active", "Inactive"]

	def index
		if current_user.is_storyteller
			@characters = Character.all
		else
			@characters = Character.where({user: current_user.id})
		end
	end

	def show
		@character = Character.find(params[:id])
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		if (@character.user.id != current_user.id && !current_user.is_storyteller)
			redirect_to root_path
		end
	end

	def new
		@character = Character.new
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		@advantages = Advantage.all
		@challenges = Challenge.all
		@player = current_user
	end

	def edit
		@character = Character.find(params[:id])
		if @character.status > 0 and !current_user.is_storyteller
			redirect_to character_path(@character)
		end
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		@advantages = Advantage.all
		@challenges = Challenge.all
		@player = @character.user
		if (@character.user.id != current_user.id && !current_user.is_storyteller)
			redirect_to root_path
		end
	end

	def update
		@character = Character.find(params[:id])
		if @character.update_attributes!(characters_params)
			flash[:success] = "Changes to your character were saved."
			if params[:character][:character_has_challenges].present?
				chc_ids = []
				# add new challenges, and catalog all the challenges that should be on the sheet
				params[:character][:character_has_challenges].each do |challenge|
					unless challenge[:id].present?
						@challenge = CharacterHasChallenge.new(character_id: @character.id, challenge_id: challenge[:challenge_id])
						@challenge.save!
						chc_ids << @challenge.id.to_i
					else
						chc_ids << challenge[:id].to_i
					end
				end
				# remove any challenges that are no longer on the sheet
				@character.character_has_challenges.each do |chc|
					unless chc_ids.include?(chc.id)
						@challenge = CharacterHasChallenge.find(chc.id)
						@challenge.delete
					end
				end
			end
			if params[:character][:character_has_advantages].present?
				cha_ids = []
				# add new advantages, and update older ones
				params[:character][:character_has_advantages].each do |advantage|
					unless advantage[:id].present?
						@advantage = CharacterHasAdvantage.new(character_id: @character.id, challenge_id: advantage[:advantage_id], rating: advantage[:rating], specification: advantage[:specification])
						@advantage.save!
					else
						# advantages have a more complex join, so we have to update attributes for non-new ones in case they haven't changed
						@advantage = CharacterHasAdvantage.find(advantage[:id])
						@advantage.update_attributes!(rating: advantage[:rating], specification: advantage[:specification])
					end
					cha_ids << @advantage.id
				end
				# remove any advantages that are no longer on the sheet
				@character.character_has_advantages.each do |cha|
					unless cha_ids.include?(cha.id)
						@advantage = CharacterHasAdvantage.find(cha.id)
						@advantage.delete
					end
				end
			end
			redirect_to character_path(@character)
		else
			flash[:error] = "There was an error saving your character."
			redirect_to edit_character_path(@character)
		end
	end

	def create
		@character = Character.new(characters_params)
		if @character.save!
			flash[:success] = "Your character was saved."
			redirect_to character_path(@character)
		else
			flash[:error] = "There was an error saving your character."
			redirect_to new_character_path
		end
	end

	def destroy
		@character = Character.find(params[:id])
		@character.delete
		redirect_to characters_path
	end

	def validate_character

	end

	protected

	def characters_params
		params.require(:character).permit(:name, :user_id, :true_self_id, :stability, :handy, :religion, :bureaucracy, :athletics, :fight, :drive, :guns, :theft, :stealth, :outdoorsy, :empathy, :artsy, :intimidation, :persuasion, :lies, :academics, :investigation, :medicine, :local_lore, :law, :science, :computers, :engineering, :public_blurb, :willpower, :defense, :speed, :intelligence, :wits, :resolve, :strength, :dexterity, :stamina, :presence, :manipulation, :composure, :speed, :initiative, :willpower, :health, :defense, :pronouns)
	end

	def get_status(status)
		STATUS_ENUM[status]
	end
end
