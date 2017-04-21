module Storytellers
  class SettingsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller
    
    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Settings", :storytellers_settings_path

    def index
      @qualitative_open = Setting.qualitative_open
      @quantitative_open = Setting.quantitative_open
    end

    def update
      Setting.qualitative_open = params[:qualitative_open]
      Setting.quantitative_open = params[:quantitative_open]

      redirect_to storytellers_settings_path and return
    end
  end
end
