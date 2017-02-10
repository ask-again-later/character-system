class CharactersController < ApplicationController
	before_action :authenticate_user!

	ATTRIBUTES = {"Mental": ["Intelligence", "Wits", "Resolve"], "Physical": ["Strength", "Dexterity", "Stamina"], "Social": ["Presence", "Manipulation", "Composure"]}
	SKILLS_TRAINING = {"Skills": ["Artsy", "Athletics", "Bureaucracy", "Drive", "Empathy", "Fight", "Guns", "Handy", "Intimidation", "Lies", "Outdoorsy", "Persuasion", "Religion", "Stealth", "Theft"], "Special Training": ["Academics", "Computers", "Engineering", "Investigation", "Law", "Local Lore", "Medicine", "Science"]}

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
	end

	def edit
		@character = Character.find(params[:id])
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		@advantages = Advantage.all
		@challenges = Challenge.all
		if (@character.user.id != current_user.id && !current_user.is_storyteller)
			redirect_to root_path
		end
	end

	def update
		@character = Character.find(params[:id])
		if @character.update_attributes!(characters_params)
			flash[:success] = "Changes to your character were saved."
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

	end

	protected

	def characters_params
		params.require(:character).permit(:name, :user_id, :true_self_id, :stability, :handy, :religion, :bureaucracy, :athletics, :fight, :drive, :guns, :theft, :stealth, :outdoorsy, :empathy, :artsy, :intimidation, :persuasion, :lies, :academics, :investigation, :medicine, :local_lore, :law, :science, :computers, :engineering, :public_blurb, :willpower, :defense, :speed, :intelligence, :wits, :resolve, :strength, :dexterity, :stamina, :presence, :manipulation, :composure, :speed, :initiative, :willpower, :health, :defense)
	end

	def validate_character

	end
end
