module Storytellers
  class UsersController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Users", :storytellers_users_path

    def index
      @users = User.all.order(:name)
    end

    def show
      @user = User.find(params[:id])
      add_breadcrumb @user.name, storytellers_user_path(@user)
    end

    def edit
      @user = User.find(params[:id])
      add_breadcrumb @user.name, storytellers_user_path(@user)
      add_breadcrumb "Edit", edit_storytellers_user_path(@user)
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(users_params)
        flash[:success] = "The user's information was updated."
        redirect_to storytellers_users_path and return
      else
        flash[:error] = "There was an error updating the user's information."
        redirect_to edit_storytellers_user_path(@user) and return
      end
    end

    def destroy
      User.destroy(params[:id])
      flash[:success] = "The user was deleted."
      redirect_to storytellers_users_path and return
    end

    private

    def users_params
      params.require(:user).permit(:name, :email, :password, :attended_info_session)
    end
  end
end
