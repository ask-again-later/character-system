module Storytellers
  class QuestionnaireItemsController < ApplicationController
    def index
      @questionnaire_items = QuestionnaireItem.all.order(order: :asc)
      @questionnaire_item = QuestionnaireItem.new
    end

    def update
  		@current_questions = QuestionnaireItem.all
  		@questions = params[:questionnaire_item]
  		@question_ids = []

  		@questions.each do |question|
  			if question[:question].present? #skip empties
  				puts question.inspect
  				if question[:id].present?
  					# Update existing questions
  					@question = QuestionnaireItem.find(question[:id].to_i)
  					@question.update_attributes!({question: question[:question], order: question[:order]})
  					@question_ids << @question.id
  				else
  					# Add new questions
  					@question = QuestionnaireItem.new({question: question[:question], order: question[:order]})
  					@question.save!
  					@question_ids << @question.id
  				end
  			end
  		end

  		# prune questions that have been removed
  		@current_questions.each do |old_q|
  			unless @question_ids.include?(old_q.id)
  				old_q.delete
  			end
  		end

  		redirect_to '/storytellers/questionnaire'
    end

    def destroy
      @questionnaire_item = QuestionnaireItem.find(params[:id])
      @questionnaire_item.destroy
      redirect_to storytellers_questionnaire_items_path
    end

    private

    def questionnaire_item_params
      params.require(:questionnaire_item).permit(:id, :question, :order)
    end
  end
end
