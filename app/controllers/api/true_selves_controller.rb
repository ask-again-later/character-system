require 'json'

module Api
  class TrueSelvesController < ApplicationController
    def index
      @true_selves = TrueSelf.all.order(:name)
      render json: @true_selves.to_json
    end

    def show
      @true_self = TrueSelf.find(params[:id])
      render json: @true_self.to_json
    end
  end
end
