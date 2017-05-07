module Storytellers
  class RitualsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Rituals", :storytellers_rituals_path
    def index
      @rituals = Ritual.all
    end

    def show
      @ritual = Ritual.find(params[:id])
      renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
			@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      add_breadcrumb @ritual.name, storytellers_ritual_path(@ritual)
    end

    def new
      @ritual = Ritual.new
      add_breadcrumb "New Ritual", new_storytellers_ritual_path
    end

    def create
      @ritual = Ritual.new(ritual_params)
      if @ritual.save
        flash[:success] = "Your ritual was saved."
        redirect_to storytellers_rituals_path and return
      else
        flash[:error] = "There was an error saving your ritual."
        redirect_to new_storytellers_ritual_path and return
      end
    end

    def edit
      @ritual = Ritual.find(params[:id])
      add_breadcrumb @ritual.name, storytellers_ritual_path(@ritual)
      add_breadcrumb "Edit", edit_storytellers_ritual_path(@ritual)
    end

    def update
      @ritual = Ritual.find(params[:id])
      if @ritual.update_attributes!(ritual_params)
        flash[:success] = "Your ritual was saved."
        redirect_to storytellers_rituals_path and return
      else
        flash[:error] = "There was an error saving your ritual."
        redirect_to edit_storytellers_ritual_path(@ritual) and return
      end
    end

    def destroy
      Ritual.destroy(params[:id])
      flash[:success] = "The ritual was deleted."
      redirect_to storytellers_rituals_path
    end

    private

    def ritual_params
      params.require(:ritual).permit(:id, :name, :focus, :trappings, :principle, :duration, :effect, {:character_ids => []})
    end
  end
end
