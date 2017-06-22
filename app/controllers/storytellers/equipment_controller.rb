module Storytellers
  class EquipmentController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Equipment", :storytellers_equipment_index_path

    def index
      @equipment = Equipment.all
    end

    def show
      @equipment = Equipment.find(params[:id])
  		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
  		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      add_breadcrumb @equipment.name, storytellers_equipment_path(@equipment)
    end

    def new
      @equipment = Equipment.new
      add_breadcrumb "New", new_storytellers_equipment_path
    end

    def create
      @equipment = Equipment.new(equipment_params)
      if @equipment.save
        flash[:success] = "Your equipment was saved."
        redirect_to storytellers_equipment_index_path and return
      else
        flash[:error] = "There was an error saving your equipment."
        redirect_to new_storytellers_equipment_path and return
      end
    end

    def edit
      @equipment = Equipment.find(params[:id])
      add_breadcrumb @equipment.name, storytellers_equipment_path(@equipment)
      add_breadcrumb "Edit", edit_storytellers_equipment_path(@equipment)
    end

    def update
      @equipment = Equipment.find(params[:id])
      if @equipment.update_attributes(equipment_params)
        flash[:success] = "Your equipment was saved."
        redirect_to storytellers_equipment_index_path and return
      else
        flash[:error] = "There was an error saving your equipment."
        redirect_to edit_storytellers_equipment_path(@equipment) and return
      end
    end

    def destroy
      Equipment.destroy(params[:id])
      flash[success] = "Your equipment was destroyed."
      redirect_to storytellers_equipment_path and return
    end

    def print_all
      @characters = Character.where(status: 2).order(:name)
  		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
  		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      render layout: 'print'
    end

    def print
      @equipment = Equipment.find(params[:id])
  		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
  		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      render layout: 'print'
    end

    private

    def equipment_params
      params.require(:equipment).permit(:id, :name, :size, :durability, :description, :equipment_type_id, {:character_ids => []}, {:equipment_quality_ids => []})
    end
  end
end
