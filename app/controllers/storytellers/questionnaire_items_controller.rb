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
        if section[:id].present?
          qs = QuestionnaireSection.find(section[:id])
          section_list << section[:id].to_i
          qs.update_attributes!(title: section[:title], instructions: section[:instructions], order: section[:order], questionnaire_items_attributes: section)
        else
          qs = QuestionnaireSection.new(title: section[:title], instructions: section[:instructions], order: section[:order], questionnaire_items_attributes: section)
          qs.save!
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

    def questionnaire_item_params
      params.require(:questionnaire_items).permit(:id, :question, :order, :questionnaire_section_id, :required, :extended)
    end
  end
end
