module Storytellers
  class DowntimeActionsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Downtime Actions", :storytellers_downtime_actions_path

    def index
      @downtimes = DowntimePeriod.all.order(id: :desc)
    end

    def show
      @downtime = DowntimeAction.find(params[:id])
    end

    def edit
      @downtime = DowntimeAction.find(params[:id])
    end

    def update
      @downtime = DowntimeAction.find(params[:id])
      if @downtime_action.update_attributes!(downtime_action_params)
        flash[:success] = "The downtime action was successfully updated."
        redirect_to storytellers_downtime_actions_path and return
      end
      flash[:error] = "There was an error updating the downtime action."
      redirect_to edit_storytellers_downtime_action_path(@downtime) and return
    end

    private

    def downtime_action_params
      params.require(:downtime_action).permit(:title, :assets, :description, :burn, :response)
    end
  end
end
