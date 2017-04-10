class DowntimeActionsController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
    @downtime_periods = DowntimePeriod.all.order(id: :desc)
  end

  def show
    @downtime_action = DowntimeAction.find(params[:id])
  end

  def new
    @downtime_action = DowntimeAction.new
  end

  def create
    @downtime_action = DowntimeAction.new(downtime_action_params)
    if @downtime_action.save!
      flash[:success] = "Your downtime action was saved."
      redirect_to character_downtime_actions_path and return
    end
    flash[:error] = "There was an error saving your downtime action."
    redirect_to new_character_downtime_action_path and return
  end

  def edit
    @downtime_action = DowntimeAction.find(params[:id])
  end

  def update
  end

  def destroy

  end

  private

  def downtime_action_params
    params.require(:downtime_action).permit(:title, :assets, :size, :description, :burn, :response, :downtime_period_id, :character_id)
  end
end
