module Data
  class AdvantagesController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    def index
      @advantages = Advantage.all
    end

    def new
      @advantage = Advantage.new
    end

    def create
      @advantage = Advantage.new(advantages_params)
      if @advantage.save!
        flash[:success] = "Advantage created."
        redirect_to data_entry_advantages_path
      else
        flash[:error] = "There was an error creating your advantage."
        redirect_to new_data_entry_advantage_path
      end
    end

    def edit
      @advantage = Advantage.find(params[:id])
    end

    def update
      @advantage = Advantage.find(params[:id])
      if @advantage.update_attributes!(advantages_params)
        flash[:success] = "Advantage saved."
        redirect_to data_entry_advantages_path
      else
        flash[:error] = "There was an error creating your advantage."
        redirect_to new_data_entry_advantage_path
      end
    end

    def destroy

    end

    protected

    def advantages_params
      params.require(:advantage).permit(:id, :name, :description, :rating, :specification, :prerequisites)
    end
  end
end
