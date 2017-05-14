module Storytellers
  class EquipmentTypesController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Equipment Types", :storytellers_equipment_types_path
    def index
      @equipment_types = EquipmentType.all
    end

    def show
      @equipment_type = EquipmentType.find(params[:id])
      add_breadcrumb @equipment_type.name, storytellers_equipment_type_path(@equipment_type)
    end

    def new
      @equipment_type = EquipmentType.new
      add_breadcrumb "New", new_storytellers_equipment_type_path
    end

    def create
      @equipment_type = EquipmentType.new(equipment_types_params)
      if @equipment_type.save
        flash[:success] = "Your equipment type was saved."
        redirect_to storytellers_equipment_types_path and return
      else
        flash[:error] = "There was an error saving your equipment type."
        redirect_to new_storytellers_equipment_type_path and return
      end
    end

    def edit
      @equipment_type = EquipmentType.find(params[:id])
      add_breadcrumb @equipment_type.name, storytellers_equipment_type_path(@equipment_type)
      add_breadcrumb "Edit", edit_storytellers_equipment_type_path(@equipment_type)
    end

    def update
      @equipment_type = EquipmentType.find(params[:id])
      if @equipment_type.update_attributes(equipment_types_params)
        flash[:success] = "Your equipment type was saved."
        redirect_to storytellers_equipment_types_path and return
      else
        flash[:error] = "There was an error saving your equipment type."
        redirect_to edit_storytellers_equipment_types_path(@equipment_type) and return
      end
    end

    def destroy
      EquipmentType.destroy(params[:id])
      flash[:success] = "Your equipment type was deleted."
      redirect_to storytellers_equipment_types_path and return
    end

    private

    def equipment_types_params
      params.require(:equipment_type).permit(:id, :name)
    end
  end
end
