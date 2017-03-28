module Storytellers
  class QuestionnaireSectionsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

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

    def update
  		sections = params[:questionnaire_section]
      section_list = []
      sections.each do |section|
        if section[:id].present?
          qs = QuestionnaireSection.find(section[:id])
          section_list << section[:id].to_i
          puts questionnaire_section_params.inspect
          qs.update_attributes!(questionnaire_section_params)
        else
          qs = QuestionnaireSection.new(title: section[:title], instructions: section[:instructions], order: section[:order], questionnaire_items_attributes: questionnaire_item_params)
          puts questionnaire_section_params.inspect
          section_list << qs.id.to_i
        end
      end
      @sections = QuestionnaireSection.all
      @sections.each do |section|
        unless section_list.include?(section.id)
          section.destroy
        end
      end

  		redirect_to '/storytellers/questionnaire'
    end

    private

    def questionnaire_section_params
      params.require(:questionnaire_section).permit(:id, :title, :instructions, :order, questionnaire_items_attributes: [:id, :question, :order, :required, :extended])
    end
  end
end
