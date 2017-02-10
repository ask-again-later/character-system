module DataEntry
  class AdvantagesController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    def index

    end
  end
end
