require 'json'

module Api
  class AdvantagesController < ApplicationController
    def index
      @advantages = Advantage.all.order(:name)
      render json: @advantages.to_json
    end

    def show
      @advantage = Advantage.find(params[:id])
      render json: @advantage.to_json
    end
  end
end
