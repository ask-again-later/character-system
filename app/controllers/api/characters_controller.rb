require 'json'

module Api
  class CharactersController < ApplicationController
    def index
      @characters = Character.where(status: 3).order(:name)
      @characters_formatted = []
      @characters.each do |character|
        @characters_formatted << {"name": character.name, "player": character.user.name, "public_blurb": character.public_blurb}
      end
      render json: @characters_formatted.to_json
    end

    def show
      @character = Character.find(params[:id])
      render json: {"name": @character.name, "player": @character.user.name, "public_blurb": @character.public_blurb}
    end
  end
end
