module Storytellers
  class QuestionnaireItemsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller
    def index
      @sections = QuestionnaireSection.all.order(order: :asc)
      @questionnaire_items = QuestionnaireItem.all.order(order: :asc)
      @questionnaire_item = QuestionnaireItem.new
    end

    def update
  		sections = params[:questionnaire_section]
      section_list = []
      sections.each do |section|
        if section[:id]
          qs = QuestionnaireSection.find(section[:id])
          section_list << section[:id]
          qs.update_attributes!(title: section[:title], instructions: section[:instructions], order: section[:order], questionnaire_items: section[:questionnaire_items])
        else
          qs = QuestionnaireSection.new(title: section[:title], instructions: section[:instructions], order: section[:order], questionnaire_items: section[:questionnaire_items])
          qs.save!
          section_list << qs.id
        end
        QuestionnaireSection.all do |section|
          unless section_list.include?(section.id)
            section.delete
          end
        end
      end

  		redirect_to '/storytellers/questionnaire'
    end

    private

    def questionnaire_item_params
      params.require(:questionnaire_item).permit(:question, :order)
    end

    def questionnaire_section_params
      params.require(:questionnaire_section).permit(:title, :order, :instructions, :questionnaire_item => [:question, :questionnaire_section_id, :order])
  end
end
