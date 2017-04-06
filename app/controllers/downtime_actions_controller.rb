class DowntimeActionsController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
    @games = Game.all
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
