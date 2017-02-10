require 'json'

module Api
  class ChallengesController < ApplicationController
    def index
      @challenges = Challenge.all.order(:name)
      render json: @challenges.to_json
    end

    def show
      @challenge = Challenge.find(params[:id])
      render json: @challenge.to_json
    end
  end
end
