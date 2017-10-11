module Storytellers
  class DowntimeActionsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Downtime Actions", :storytellers_downtime_actions_path

    ACTION_TYPE_ENUM = [["Preserve", 1], ["Change", 2], ["Gather Knowledge", 3], ["Personal Errand", 4]]

    def index
      @downtimes = DowntimePeriod.where(is_active: true).order(id: :desc)
    end

    def show
      @downtime = DowntimeAction.find(params[:id])
    end

    def downtime_period
      @downtime_period = DowntimePeriod.find(params[:downtime_period_id])
      @downtime_actions = DowntimeAction.where(downtime_period_id: params[:downtime_period_id])
      @action_types = ACTION_TYPE_ENUM
  		renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
  		@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
        add_breadcrumb @downtime_period.title, storytellers_downtime_actions_downtime_period_path(@downtime_period)
    end

    def downtime_period_print
      @downtime_period = DowntimePeriod.find(params[:downtime_period_id])
      @downtime_actions = DowntimeAction.where(downtime_period_id: params[:downtime_period_id])
      renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
      @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  		render layout: 'print'
    end

    def edit
      @downtime_action = DowntimeAction.find(params[:id])
      @action_types = ACTION_TYPE_ENUM

      add_breadcrumb @downtime_action.downtime_period.title, storytellers_downtime_actions_downtime_period_path(@downtime_action.downtime_period)
      add_breadcrumb "#{@downtime_action.character.name}: #{@downtime_action.title}", edit_storytellers_downtime_action_path(@downtime_action)
    end

    def update
      @downtime_action = DowntimeAction.find(params[:id])
      if @downtime_action.update_attributes!(downtime_action_params)
        flash[:success] = "The downtime action was successfully updated."
        redirect_to storytellers_downtime_actions_downtime_period_path(@downtime_action.downtime_period) and return
      end
      flash[:error] = "There was an error updating the downtime action."
      redirect_to edit_storytellers_downtime_action_path(@downtime_action) and return
    end

    private

    def downtime_action_params
      params.require(:downtime_action).permit(:title, :assets, :description, :burn, :response)
    end
  end
end
