require 'json'

module Api
  class CharactersController < ApplicationController
    def index
      @characters = Character.all.order(:name)
      render json: @characters.to_json
    end

    def show
      @character = Character.find(params[:id])
      render json: @character.to_json
    end
  end
end
