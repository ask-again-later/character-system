class DowntimeActionsController < ApplicationController
  TYPE_ENUM = [["Preserve", 1], ["Change", 2], ["Gather Knowledge", 3], ["Personal Errand", 4]]

  def index
    @character = Character.find(params[:character_id])
    @downtime_periods = DowntimePeriod.all.order(id: :desc)
    @types = TYPE_ENUM
  end

  def show
    @downtime_action = DowntimeAction.find(params[:id])
  end

  def new
    @downtime_action = DowntimeAction.new
    @types = TYPE_ENUM
  end

  def create
    @downtime_action = DowntimeAction.new(downtime_action_params)
    if @downtime_action.save!
      flash[:success] = "Your downtime action was saved."
      redirect_to character_downtime_actions_path(@downtime_action.character) and return
    end
    flash[:error] = "There was an error saving your downtime action."
    redirect_to new_character_downtime_period_downtime_action_path(@downtime_action.character, params[:downtime_period_id]) and return
  end

  def edit
    @downtime_action = DowntimeAction.find(params[:id])
    @types = TYPE_ENUM
  end

  def update
    @downtime_action = DowntimeAction.find(params[:id])
    if @downtime_action.update_attributes!(downtime_action_params)
      flash[:success] = "Your downtime action was saved."
      redirect_to character_downtime_actions_path and return
    end
    flash[:error] = "There was an error saving your downtime action."
    redirect_to edit_character_downtime_period_downtime_action_path(params[:character_id], params[:downtime_period_id], @downtime_action) and return
  end

  def destroy
    @downtime_action = DowntimeAction.find(params[:id])
    @character = Character.find(params[:character_id])
    @downtime_action.destroy
    redirect_to character_downtime_actions_path(@character) and return
  end

  def submit
    @downtime_actions = DowntimeAction.where(character_id: params[:character_id], downtime_period_id: params[:downtime_period_id])
    @storytellers = User.where(is_storyteller: true)
    @downtime_period = DowntimePeriod.find(params[:downtime_period_id])
    @character = Character.find(params[:character_id])
    @storytellers.each do |storyteller|
      DowntimeActionMailer.submit(@character, @downtime_period, storyteller).deliver_now
    end
    @downtime_actions.each do |action|
      action.update_attributes!(status: 1)
    end
    redirect_to character_downtime_actions_path and return
  end

  def reopen
    @downtime_actions = DowntimeAction.where(character_id: params[:character_id], downtime_period_id: params[:downtime_period_id])
    @downtime_actions.each do |action|
      action.update_attributes!(status: 0)
    end
    redirect_to character_downtime_actions_path and return
  end

  private

  def downtime_action_params
    params.require(:downtime_action).permit(:title, :assets, :size, :description, :burn, :response, :downtime_period_id, :character_id, :action_type)
  end
end
