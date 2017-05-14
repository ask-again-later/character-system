require 'json'

module Api
  class CharactersController < ApplicationController
    def index
      @characters = Character.where(status: 2, is_npc: false).order(:name)
      @characters_formatted = []
      @characters.each do |character|
        @characters_formatted << {"name": character.name, "player": character.user.name, "public_blurb": character.public_blurb}
      end
      render json: @characters_formatted.to_json
    end

    def show
      @character = Character.find(params[:id])
      if @character.status == 2 and !@character.is_npc
        render json: {"name": @character.name, "player": @character.user.name, "public_blurb": @character.public_blurb}
      end
    end
  end
end
