module Storytellers
  class AdvantagesController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Advantages", :storytellers_advantages_path

    def index
      @advantages = Advantage.all
    end

    def show
      @advantage = Advantage.find(params[:id])
      renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
			@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      add_breadcrumb @advantage.name, storytellers_advantage_path(@advantage)
    end

    def new
      @advantage = Advantage.new
      @allowed_ratings = []
      add_breadcrumb "New Advantage", new_storytellers_advantage_path
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
      add_breadcrumb "Edit Advantage: #{@advantage.name}", edit_storytellers_advantage_path(@advantage)
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
      params.require(:advantage).permit(:id, :name, :description, :prerequisites, :allowed_ratings, :requires_specification)
    end
  end
end
