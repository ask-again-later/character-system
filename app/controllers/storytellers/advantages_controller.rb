module Storytellers
  class AdvantagesController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    def index
      @advantages = Advantage.all
    end

    def show
      @advantage = Advantage.find(params[:id])
    end

    def new
      @advantage = Advantage.new
      @allowed_ratings = []
    end

    def create
      params[:advantage][:allowed_ratings] = params[:advantage][:allowed_ratings].join(",")
      @advantage = Advantage.new(advantages_params)
      if @advantage.save!
        flash[:success] = "New advantage created."
        redirect_to storytellers_advantages_path
      else
        flash[:error] = "There was an error saving your advantage."
        redirect_to new_storytellers_advantage_path
      end
    end

    def edit
      @advantage = Advantage.find(params[:id])
      @allowed_ratings = @advantage.allowed_ratings.to_s.split(",").map { |x| x.to_i }
    end

    def update
      @advantage = Advantage.find(params[:id])
      params[:advantage][:allowed_ratings] = params[:advantage][:allowed_ratings].join(",")
      if @advantage.update_attributes!(advantages_params)
        flash[:success] = "Your advantage was successfully updated."
        redirect_to storytellers_advantages_path
      else
        flash[:error] = "There was an error saving your advantage."
        redirect_to edit_storytellers_advantage_path(@advantage)
      end
    end

    private

    def advantages_params
      params.require(:advantage).permit(:id, :name, :description, :prerequisites, :allowed_ratings)
    end
  end
end
