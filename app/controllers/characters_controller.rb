class CharactersController < ActionController::Base
	before_action :check_login

	def index

	end

	def show

	end

	def new

	end

	def edit

	end

	def update

	end

	def create

	end

	def destroy

	end

	protected

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