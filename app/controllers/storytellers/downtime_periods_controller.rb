module Storytellers
  class DowntimePeriodsController < ApplicationController
    def index
      @downtime_periods = DowntimePeriod.all
    end

    def show
      @downtime_period = DowntimePeriod.find(params[:id])
    end

    def new
      @downtime_period = DowntimePeriod.new
    end

    def create
      @downtime_period = DowntimePeriod.new(downtime_period_params)
      if @downtime_period.save!
        flash[:success] = "Your downtime period was successfully added."
        redirect_to storytellers_downtime_periods_path and return
      end
      flash[:error] = "There was an error adding your downtime period."
      redirect_to new_storytellers_downtime_period_path and return
    end

    def edit
      @downtime_period = DowntimePeriod.find(params[:id])
    end

    def update
      @downtime_period = DowntimePeriod.find(params[:id])
      if @downtime_period.update_attributes!(downtime_period_params)
        flash[:success] = "Your downtime period was successfully updated."
        redirect_to storytellers_downtime_periods_path and return
      end
      flash[:error] = "There was an error updating your downtime period."
      redirect_to edit_storytellers_downtime_period_path(@downtime_period) and return
    end

    def destroy
      @downtime_period = DowntimePeriod.find(params[:id])
      @downtime_period.destroy
      flash[:success] = "Your downtime period was successfully deleted."
      redirect_to storytellers_downtime_periods_path
    end

    private

    def downtime_period_params
      params.require(:downtime_period).permit(:title, :downtimes_visible, :downtimes_open, :is_active)
    end
  end
end
