module Storytellers
  class GamesController < ApplicationController
    def index
      @games = Game.all
    end

    def new
      @game = Game.new
    end

    def create
      @game = Game.new(game_params)
      if @game.save!
        flash[:success] = "Your game was successfully added."
        redirect_to storytellers_games_path and return
      end
      flash[:error] = "There was an error adding your game."
      redirect_to new_storytellers_game_path and return
    end

    def edit
      @game = Game.find(params[:id])
    end

    def update
      @game = Game.find(params[:id])
      if @game.update_attributes!(game_params)
        flash[:success] = "Your game was successfully updated."
        redirect_to storytellers_games_path and return
      end
      flash[:error] = "There was an error updating your game."
      redirect_to edit_storytellers_game_path(@game) and return
    end

    def destroy
      @game = Game.find(params[:id])
      @game.destroy
      flash[:success] = "Your game was successfully deleted."
      redirect_to storytellers_games_path
    end

    private

    def game_params
      params.require(:game).permit(:title, :downtimes_visible)
    end
  end
end
