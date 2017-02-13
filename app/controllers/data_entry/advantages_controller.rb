module DataEntry
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
    end

    def create
      @advantage = Advantage.new(advantages_params)
      if @advantage.save!
        flash[:success] = "New advantage created."
        redirect_to data_entry_advantages_path
      else
        flash[:error] = "There was an error saving your advantage."
        redirect_to new_data_entry_advantage_path
      end
    end

    def edit
      @advantage = Advantage.find(params[:id])
    end

    def update
      @advantage = Advantage.find(params[:id])
      if @advantage.update_attributes!(advantages_params)
        flash[:success] = "Your advantage was successfully updated."
        redirect_to data_entry_advantages_path
      else
        flash[:error] = "There was an error saving your advantage."
        redirect_to edit_data_entry_advantage_path(@advantage)
      end
    end

    private

    def advantages_params
      params.require(:advantage).permit(:id, :name, :description, :prerequisites)
    end
  end
end
