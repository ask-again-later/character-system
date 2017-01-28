class CharactersController < ActionController::Base
	before_action :check_login

	def index
		if current_user.is_storyteller
			@characters = Character.all
		else
			@characters = Character.where({user: current_user.id})
		end
	end

	def show
		@character = Character.find(params[:id])
		if (@character.id.not != current_user.id && !current_user.is_storyteller)
			redirect_to root_path
		end
	end

	def new
		@character = Character.new
	end

	def edit
		@character = Character.find(params[:id])
		if (@character.id.not != current_user.id && !current_user.is_storyteller)
			redirect_to root_path
		end
	end

	def update

	end

	def create

	end

	def destroy

	end

	protected

	def characters_params
		params.require(:character).permit(:name, :user_id, :true_self_id, :stability, :handy, :religion, :bureaucracy, :athletics, :fight, :drive, :guns, :theft, :stealth, :outdoorsy, :empathy, :artsy, :intimidation, :persuasion, :lies, :academics, :investigation, :medicine, :local_lore, :law, :science, :computers, :engineering, :public_blurb, :willpower, :defense, :speed)
	end

	def check_login
		unless is_logged_in?
			redirect_to new_user_session_path
		end
	end

  def is_logged_in?
		if User.find_by_id(session[:user_id])
			return true
		end
		return false
	end

	def is_admin?
		if is_logged_in? and @current_user.is_admin
			return true
		end
		return false
	end

	def is_storyteller?
		if is_logged_in? and @current_user.is_storyteller
			return true
		end
		return false
	end
end