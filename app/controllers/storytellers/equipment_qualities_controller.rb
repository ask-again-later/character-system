module Storytellers
  class EquipmentQualitiesController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Equipment Qualities", :storytellers_equipment_qualities_path
    def index
      @qualities = EquipmentQuality.all
    end

    def show
      @quality = EquipmentQuality.find(params[:id])
      add_breadcrumb @quality.name, storytellers_equipment_quality_path(@quality)
    end

    def new
      @quality = EquipmentQuality.new
      add_breadcrumb "New", new_storytellers_equipment_quality_path
    end

    def create
      @quality = EquipmentQuality.new(equipment_qualities_params)
      if @quality.save
        flash[:success] = "Your equipment quality was saved."
        redirect_to storytellers_equipment_qualities_path and return
      else
        flash[:error] = "There was an error saving your equipment quality."
        redirect_to new_storytellers_equipment_quality_path and return
      end
    end

    def edit
      @quality = EquipmentQuality.find(params[:id])
      add_breadcrumb @quality.name, storytellers_equipment_quality_path(@quality)
      add_breadcrumb "Edit", edit_storytellers_equipment_quality_path(@quality)
    end

    def update
      @quality = EquipmentQuality.find(params[:id])
      if @quality.update_attributes(equipment_qualities_params)
        flash[:success] = "Your equipment quality was saved."
        redirect_to storytellers_equipment_qualities_path and return
      else
        flash[:error] = "There was an error saving your equipment quality."
        redirect_to edit_storytellers_equipment_qualities_path(@quality) and return
      end
    end

    def destroy
      EquipmentQuality.destroy(params[:id])
      flash[:success] = "Your equipment quality was deleted."
      redirect_to storytellers_equipment_qualities_path and return
    end

    private

    def equipment_qualities_params
      params.require(:equipment_qualities).permit(:id, :name, :description, :equipment_type_id, {:equipment_ids => []})
    end
  end
end
