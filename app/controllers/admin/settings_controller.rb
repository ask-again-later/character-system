module Admin
  class SettingsController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @users = User.all
    end

    def update

    end
  end
end
