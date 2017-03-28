module Storytellers
  class QuestionnaireSectionsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller, :except => :reorder_sections

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Questionnaire Sections", :storytellers_questionnaire_sections_path
    def index
      @sections = QuestionnaireSection.all.order(order: :asc)
    end

    def show
  		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
  		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      @section = QuestionnaireSection.find(params[:id])
      add_breadcrumb @section.title, storytellers_questionnaire_section_path(@section)
    end

    def new
      @questionnaire_section = QuestionnaireSection.new
      add_breadcrumb "New", new_storytellers_questionnaire_section_path
    end

    def edit
      @questionnaire_section = QuestionnaireSection.find(params[:id])
      add_breadcrumb @questionnaire_section.title, storytellers_questionnaire_section_path(@questionnaire_section)
      add_breadcrumb "Edit", edit_storytellers_questionnaire_section_path(@questionnaire_section)
    end

    def create
      @section = QuestionnaireSection.new(questionnaire_section_params)
      if @section.save!
        flash[:success] = "The questionnaire section was added."
        redirect_to storytellers_questionnaire_section_path(@section) and return
      end
      flash[:error] = "There was an error creating a new questionnaire section."
      redirect_to new_storytellers_questionnaire_section_path
    end

    def update
      @section = QuestionnaireSection.find(params[:id])
      if @section.update_attributes!(questionnaire_section_params)
        flash[:success] = "The questionnaire section was updated."
  		  redirect_to storytellers_questionnaire_section_path(@section) and return
      end
      flash[:error] = "There was an error updating this section."
      redirect_to edit_storytellers_questionnaire_section_path(@section) and return
    end

    def reorder_sections
      @sections = params[:questionnaire_sections]
      @sections.each do |section|
        @qs = QuestionnaireSection.find(section[:id])
        @qs.update_attributes!(order: section[:order])
      end
    end

    private

    def questionnaire_section_params
      params.require(:questionnaire_section).permit(:id, :title, :instructions, :order, questionnaire_items_attributes: [:id, :question, :order, :required, :extended, :_destroy])
    end
  end
end
