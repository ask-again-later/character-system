module Storytellers
  class RitualsController < ApplicationController
    def index
      @rituals = Ritual.all
    end

    def show
      @ritual = Ritual.find(params[:id])
    end

    def new
      @ritual = Ritual.new
    end

    def create

    end

    def edit
      @ritual = Ritual.find(params[:id])
    end

    def update
      @ritual = Ritual.find(params[:id])
    end

    def destroy
      Ritual.destroy(params[:id])
      redirect_to storytellers_rituals_path
    end
  end
end
