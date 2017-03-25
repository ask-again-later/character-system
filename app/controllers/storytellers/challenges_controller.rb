module Storytellers
  class ChallengesController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Challenges", :storytellers_challenges_path
    add_breadcrumb "New", :new_storytellers_challenge_path
    add_breadcrumb "Edit", :edit_storytellers_challenge_path

    def index
      @challenges = Challenge.all
    end

    def show
      @challenge = Challenge.find(params[:id])
      renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
			@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    end

    def new
      @challenge = Challenge.new
    end

    def create
      @challenge = Challenge.new(challenges_params)
      if @challenge.save!
        flash[:success] = "New challenge created."
        redirect_to storytellers_challenges_path
      else
        flash[:error] = "There was an error saving your challenge."
        redirect_to new_storytellers_challenge_path
      end
    end

    def edit
      @challenge = Challenge.find(params[:id])
    end

    def update
      @challenge = Challenge.find(params[:id])
      if @challenge.update_attributes!(challenges_params)
        flash[:success] = "Your challenge was successfully updated."
        redirect_to storytellers_challenges_path
      else
        flash[:error] = "There was an error saving your challenge."
        redirect_to edit_storytellers_challenge_path(@challenge)
      end
    end

    private

    def challenges_params
      params.require(:challenge).permit(:id, :name, :description, :is_creature_challenge, :is_custom)
    end
  end
end
