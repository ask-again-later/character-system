class CharactersController < ApplicationController
	before_action :authenticate_user!

	ATTRIBUTES = {"Mental": ["Intelligence", "Wits", "Resolve"], "Physical": ["Strength", "Dexterity", "Stamina"], "Social": ["Presence", "Manipulation", "Composure"]}
	SKILLS_TRAINING = {"Skills": ["Artsy", "Athletics", "Bureaucracy", "Drive", "Empathy", "Fight", "Guns", "Handy", "Intimidation", "Lies", "Outdoorsy", "Persuasion", "Religion", "Stealth", "Theft"], "Special Training": ["Academics", "Computers", "Engineering", "Investigation", "Law", "Local Lore", "Medicine", "Science"]}
	STATUS_ENUM = [["In Progress", 0], ["Submitted", 1], ["Active", 2], ["Inactive", 3]]

	def index
		if current_user.is_storyteller
			@characters = Character.where({is_npc: false})
		else
			@characters = Character.where({user: current_user.id})
		end
	end

	def npcs
		unless current_user.is_storyteller
			redirect_to root_path and return
		end

		@characters = Character.where({is_npc: true})
	end

	def show
		@character = Character.find(params[:id])
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		@questionnaire_sections = QuestionnaireSection.all.order(order: :asc)
		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
		if (@character.user.id != current_user.id && !current_user.is_storyteller)
			redirect_to root_path
		end
	end

	def print
		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
		show
		render layout: 'print'
	end

	def new
		@character = Character.new
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		@advantages = Advantage.all.order(:name)
		@challenges = Challenge.where(is_custom: false).order(:name)
		@custom_challenge = Challenge.where(is_custom: true).first
		@player = current_user
		@statuses = STATUS_ENUM
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

	def new_npc
		@character = Character.new(is_npc: true, status: 3, user_id: current_user.id)
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		@advantages = Advantage.all.order(:name)
		@challenges = Challenge.where(is_custom: false).order(:name)
		@statuses = [["Active", 2], ["Inactive", 3]]
		@custom_challenge = Challenge.where(is_custom: true).first
	end

	def edit
		@character = Character.find(params[:id])
		if (@character.user.id != current_user.id && !current_user.is_storyteller)
			redirect_to root_path and return
		end
		if @character.status > 0 and !current_user.is_storyteller and @character.current_xp <= 0
			redirect_to character_path(@character) and return
		end
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		@advantages = Advantage.all.order(:name)
		@challenges = Challenge.where(is_custom: false).order(:name)
		@custom_challenge = Challenge.where(is_custom: true).first
		@player = @character.user
		@questionnaire_sections = QuestionnaireSection.all.order(order: :asc)
		if @character.is_npc
			@statuses = [["Active", 2], ["Inactive", 3]]
		else
			@statuses = STATUS_ENUM
		end

		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
		if !@character.use_extended
			@questionnaire = @questionnaire.to_a.reject!{|q| q.questionnaire_items.where(extended: false).empty?}
		end
		@questionnaire_items = QuestionnaireItem.all.order(order: :asc)
		@questionnaire_answers = @character.questionnaire_answers
	end

	def update
		@character = Character.find(params[:id])
		oldstatus = @character.status
		if params[:submit].present? && params[:submit]
			@character.status = 1
		end
		if @character.status == 2 and !current_user.is_storyteller
			params[:character][:id] = @character.id
			@character_updated = Character.new(characters_params)
			diff = @character.diff(@character_updated)
			@expenditure = XpExpenditure.new(character_id: @character.id, diff: diff.to_json)
			@expenditure.save
			@storytellers = User.where(is_storyteller: true)
			@storytellers.each do |st|
				CharacterMailer.character_experience_expenditure(@character, @expenditure, st).deliver_now
			end
			flash[:success] = "Experience expenditure for #{@character.name} submitted."
			redirect_to character_path(@character) and return
		end
		if @character.status == 0 and ((@character.use_extended and !Setting.qualitative_open) or !Setting.quantitative_open) and !current_user.is_storyteller
			# set status to In Progress even if they submitted
			params[:character][:status] = 0
			@character.update_attributes(characters_params)
			flash[:error] = "Submissions of this type are currently closed. Your character sheet has been saved, but not submitted."
			redirect_to character_path(@character) and return
		end
		if @character.update_attributes!(characters_params)
			flash[:success] = "Changes to your character were saved."
			# send mailers if necessary
			if oldstatus != @character.status
				if @character.status == 1 and !current_user.is_storyteller
					# send submission notification to storytellers
					@storytellers = User.where(is_storyteller: true)
					@storytellers.each do |storyteller|
						CharacterMailer.character_submission(@character, storyteller).deliver_now
					end
					CharacterMailer.character_submission_receipt(@character).deliver_now
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
			# send mailers if necessary
			if @character.status == 1 && !current_user.is_storyteller
				# send submission notification to storytellers
				@storytellers = User.where(is_storyteller: true)
				@storytellers.each do |storyteller|
					CharacterMailer.character_submission(@character, storyteller).deliver_now
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
		@character.destroy
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
		
		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
		@page = @questionnaire[params[:page].to_i-1]
		@questionnaire_answers = @character.questionnaire_answers
	end

	def wizard_basics
		@questionnaire = QuestionnaireSection.all.order(:order)
		@character = Character.find(params[:id])
		@attributes = ATTRIBUTES
		@is_basics = true
		unless @character.present?
			redirect_to new_character_wizard_path and return
		end
	end

	def wizard_skills_trainings
		@questionnaire = QuestionnaireSection.all.order(:order)
		@character = Character.find(params[:id])
		@skills_training = SKILLS_TRAINING
		@is_skills = true
		unless @character.present?
			redirect_to new_character_wizard_path and return
		end
	end

	def wizard_challenges_advantages
		@questionnaire = QuestionnaireSection.all.order(:order)
		@character = Character.find(params[:id])
		@advantages = Advantage.all.order(:name)
		@challenges = Challenge.where(is_custom: false).order(:name)
		@custom_challenge = Challenge.where(is_custom: true).first
		@is_challenges = true

		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
		unless @character.present?
			redirect_to new_character_wizard_path and return
		end
	end

	def delete_expenditure
		@character = Character.find(params[:id])
		unless current_user == @character.user or current_user.is_storyteller
			redirect_to root_path and return
		end
		XpExpenditure.destroy(params[:expenditure_id])
		redirect_to character_path(@character) and return
	end

	def dramatis
		unless current_user.is_storyteller or current_user.characters.where({status: 2}).length > 0
			flash[:error] = "Sorry, only storytellers and players of active characters can view the Dramatis Personae."
			redirect_to root_path and return
		end

		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
		@characters = Character.where({status: 2, is_secret: false}).order(:name)
	end

	def print_all
		unless current_user.is_storyteller
			redirect_to root_path and return
		end
		@characters = Character.where({status: 2}).order(:name)
		@attributes = ATTRIBUTES
		@skills_training = SKILLS_TRAINING
		@questionnaire_sections = QuestionnaireSection.all.order(order: :asc)

		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})

		render layout: 'print'
	end

	def print_all_mechanics
		unless current_user.is_storyteller
			redirect_to root_path and return
		end
		@characters = Character.where({status: 2}).order(:name)

		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
		render layout: 'print'
	end


	def send_approvals
		unless current_user.is_storyteller
			redirect_to root_path and return
		end
		@characters = Character.where(status: 2).where.not(approval_sent: true, is_npc: true)
		@characters.each do |character|
			CharacterMailer.character_approval(character).deliver_now
			character.update_attributes!(approval_sent: true)
		end
		redirect_to root_path and return
	end

	protected

	def characters_params
		params.require(:character).permit(:id, :name, :user_id, :status, :is_secret, :motivation, :true_self_id, :stability, :handy, :religion, :bureaucracy, :athletics, :fight, :drive, :guns, :theft, :stealth, :outdoorsy, :empathy, :artsy, :intimidation, :persuasion, :lies, :academics, :investigation, :medicine, :local_lore, :law, :science, :computers, :engineering, :public_blurb, :willpower, :defense, :speed, :intelligence, :wits, :resolve, :strength, :dexterity, :stamina, :presence, :manipulation, :composure, :speed, :initiative, :willpower, :health, :defense, :pronouns, :additional_info, :use_extended, :is_npc, :character_has_advantages_attributes => [:id, :advantage_id, :character_id, :specification, :rating, :_destroy], :character_has_challenges_attributes => [:id, :character_id, :challenge_id, :custom_name, :custom_description, :is_creature_challenge, :_destroy], :questionnaire_answers_attributes => [:id, :questionnaire_item_id, :answer, :character_id])
	end
end
