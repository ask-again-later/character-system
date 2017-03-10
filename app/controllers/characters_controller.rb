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
		@questionnaire_sections = QuestionnaireSection.all.order(order: :asc)
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
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
		@questionnaire_sections = QuestionnaireSection.all.order(order: :asc)
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
		@questionnaire_items = QuestionnaireItem.all.order(order: :asc)
		@questionnaire_items.each do |q|
			QuestionnaireAnswer.new(character: @character,
															questionnaire_item: q)
		end
		@questionnaire_answers = @character.questionnaire_answers
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
		@questionnaire_sections = QuestionnaireSection.all.order(order: :asc)
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
		@questionnaire_items = QuestionnaireItem.all.order(order: :asc)
		@questionnaire_answers = @character.questionnaire_answers
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
						@advantage = CharacterHasAdvantage.new(character_id: @character.id, advantage_id: advantage[:advantage_id], rating: advantage[:rating], specification: advantage[:specification])
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
			if params[:character][:questionnaire_answers].present?
				params[:character][:questionnaire_answers].each do |qa|
					if qa[:id].present?
						@qa = QuestionnaireAnswer.find(qa[:id])
						@qa.update_attributes!(answer: qa[:answer])
					else
						@qa = QuestionnaireAnswer.new(answer: qa[:answer], character_id: @character.id, questionnaire_item_id: qa[:questionnaire_item_id])
						@qa.save!
					end
				end
			end
			if params[:wizard].present?
				if params[:formaction] == "save"
					redirect_to "/characters/#{@character.id}/wizard/#{params[:wizard_current]}" and return
				elsif params[:formaction] == "save-back"
					redirect_to "/characters/#{@character.id}/wizard/#{params[:wizard_prev]}" and return
				elsif params[:formaction] == "save-continue"
					redirect_to "/characters/#{@character.id}/wizard/#{params[:wizard]}" and return
				elsif params[:formaction] == "save-skip"
					redirect_to edit_character_path(@character) and return
				elsif params[:formaction] == "switch-non-mechanics"
					@first_qual = QuestionnaireSection.all.order(:order)
					@first_qual = @first_qual.to_a.reject! {|q| q.questionnaire_items.where(extended: false).any? }
					redirect_to "/characters/#{@character.id}/wizard/#{@first_qual.first.id}" and return
				else
					redirect_to character_path(@character) and return
				end
			end
			redirect_to character_path(@character) and return
		else
			flash[:error] = "There was an error saving your character."
			if params[:wizard].present?
				redirect_to "/characters/#{@character.id}/wizard/#{params[:wizard_current]}" and return
			end
			redirect_to edit_character_path(@character) and return
		end
	end

	def create
		@character = Character.new(characters_params)
		if @character.save!
			flash[:success] = "Your character was saved."
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
						@advantage = CharacterHasAdvantage.new(character_id: @character.id, advantage_id: advantage[:advantage_id], rating: advantage[:rating], specification: advantage[:specification])
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
			if params[:character][:questionnaire_answers].present?
				params[:character][:questionnaire_answers].each do |qa|
					@qa = QuestionnaireAnswer.new(answer: qa[:answer], character_id: @character.id, questionnaire_item_id: qa[:questionnaire_item_id])
					@qa.save!
				end
			end
			if params[:wizard].present?
				if params[:formaction] == "save"
					redirect_to "/characters/#{@character.id}/wizard/#{params[:wizard_current]}" and return
				elsif params[:formaction] == "save-continue"
					redirect_to "/characters/#{@character.id}/wizard/#{params[:wizard]}" and return
				elsif params[:formaction] == "save-skip"
					redirect_to edit_character_path(@character) and return
				elsif params[:formaction] == "switch-non-mechanics"
					@first_qual = QuestionnaireSection.all.order(:order)
					@first_qual = @first_qual.to_a.reject! {|q| q.questionnaire_items.where(extended: false)}
					redirect_to "/characters/#{@character.id}/wizard/#{@first_qual.first.id}" and return
				else
					redirect_to character_path(@character) and return
				end
			end
			redirect_to character_path(@character) and return
		else
			flash[:error] = "There was an error saving your character."
			if params[:wizard].present?
				redirect_to new_character_wizard_path and return
			end
			redirect_to new_character_path and return
		end
	end

	def destroy
		@character = Character.find(params[:id])
		@character.delete
		redirect_to characters_path
	end

	def wizard
		@questionnaire = QuestionnaireSection.all.order(:order)
		@section = @questionnaire.first
		if params[:id].present?
			@character = Character.find(params[:id])
		else
			@character = Character.new
		end
	end

	def wizard_questionnaire
		@questionnaire = QuestionnaireSection.all.order(:order)
		@character = Character.find(params[:id])
		unless @character.present?
			redirect_to new_character_wizard_path and return
		end
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
		@page = @questionnaire[params[:page].to_i-1]
		@questionnaire_answers = @character.questionnaire_answers
	end

	def wizard_basics
		@questionnaire = QuestionnaireSection.all.order(:order)
		@character = Character.find(params[:id])
		@attributes = ATTRIBUTES
		unless @character.present?
			redirect_to new_character_wizard_path and return
		end
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
	end

	def wizard_skills_trainings
		@questionnaire = QuestionnaireSection.all.order(:order)
		@character = Character.find(params[:id])
		@skills_training = SKILLS_TRAINING
		unless @character.present?
			redirect_to new_character_wizard_path and return
		end
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
	end

	def wizard_challenges_advantages
		@questionnaire = QuestionnaireSection.all.order(:order)
		@character = Character.find(params[:id])
		@advantages = Advantage.all.order(:name)
		@challenges = Challenge.all.order(:name)
		unless @character.present?
			redirect_to new_character_wizard_path and return
		end
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
	end

	def validate_character

	end

	protected

	def characters_params
		params.require(:character).permit(:name, :user_id, :true_self_id, :stability, :handy, :religion, :bureaucracy, :athletics, :fight, :drive, :guns, :theft, :stealth, :outdoorsy, :empathy, :artsy, :intimidation, :persuasion, :lies, :academics, :investigation, :medicine, :local_lore, :law, :science, :computers, :engineering, :public_blurb, :willpower, :defense, :speed, :intelligence, :wits, :resolve, :strength, :dexterity, :stamina, :presence, :manipulation, :composure, :speed, :initiative, :willpower, :health, :defense, :pronouns, :use_extended)
	end

	def get_status(status)
		STATUS_ENUM[status]
	end
end
