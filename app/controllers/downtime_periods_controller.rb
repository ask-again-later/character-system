class DowntimePeriodsController < ApplicationController
  def show
    @downtime_actions = DowntimeAction.where(character_id: params[:character_id], downtime_period_id: params[:id])
    @character = Character.find(params[:character_id])
    @downtime_period = DowntimePeriod.find(params[:id])
  end
end
