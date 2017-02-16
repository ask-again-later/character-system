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
		@questionnaire_items = QuestionnaireItem.all.order(order: :asc)
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
		@questionnaire_items = QuestionnaireItem.all.order(order: :asc)
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
		@questionnaire_items = QuestionnaireItem.all.order(order: :asc)
		@questionnaire_answers = QuestionnaireAnswer.where(character: params[:id])
		if (@character.user.id != current_user.id && !current_user.is_storyteller)
			redirect_to root_path
		end
	end

	def update
		@character = Character.find(params[:id])
		if @character.update_attributes!(characters_params)
			flash[:success] = "Changes to your character were saved."
			params[:character][:questionnaire_answers].each do |qa|
				if qa[:id].present?
					@qa = QuestionnaireAnswer.find(qa[:id])
					@qa.update_attributes!(answer: qa[:answer])
				else
					@qa = QuestionnaireAnswer.new(answer: qa[:answer], character_id: @character.id, questionnaire_item_id: qa[:questionnaire_item_id])
					@qa.save!
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
			params[:character][:questionnaire_answers].each do |qa|
				@qa = QuestionnaireAnswer.new(answer: qa[:answer], character_id: @character.id, questionnaire_item_id: qa[:questionnaire_item_id])
				@qa.save!
			end
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
		params.require(:character).permit(:name, :user_id, :true_self_id, :stability, :handy, :religion, :bureaucracy, :athletics, :fight, :drive, :guns, :theft, :stealth, :outdoorsy, :empathy, :artsy, :intimidation, :persuasion, :lies, :academics, :investigation, :medicine, :local_lore, :law, :science, :computers, :engineering, :public_blurb, :willpower, :defense, :speed, :intelligence, :wits, :resolve, :strength, :dexterity, :stamina, :presence, :manipulation, :composure, :speed, :initiative, :willpower, :health, :defense, :pronouns, :character_has_challenges => [:character_id, :challenge_id], :character_has_advantages => [:character_id, :advantage_id, :specification])
	end

	def get_status(status)
		STATUS_ENUM[status]
	end
end
