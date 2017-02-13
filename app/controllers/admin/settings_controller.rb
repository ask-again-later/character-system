module Admin
  class SettingsController < ApplicationController
    before_action :authenticate_user!, :is_admin

    def index
      @users = User.all
    end

    def update
      @users = User.all
      @users.each do |user|
        if params[:users].include?(user.id.to_s)
          user.update_attributes!({is_storyteller: true})
        else
          user.update_attributes!({is_storyteller: false})
        end
      end
      redirect_to "/admin"
    end

    protected

    def is_admin
      unless current_user.is_admin
        redirect_to root_path
      end
    end
  end
end
