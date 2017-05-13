module Storytellers
  class UsersController < ActionController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Users", :storytellers_users_path
    def index

    end

    def show

    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def users_params

    end
  end
end
