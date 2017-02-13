module DataEntry
  class TrueSelvesController < ApplicationController
    def index
      @true_selves = TrueSelf.all
    end

    def new
      @true_self = TrueSelf.new
    end

    def create
      @true_self = TrueSelf.new(true_self_params)
      if @true_self.save!
        flash[:success] = "Your true self was created."
        redirect_to data_entry_true_selves_path
      else
        flash[:error] = "There was an error creating your true self."
        redirect_to new_data_entry_true_self_path
      end
    end

    def edit
      @true_self = TrueSelf.find(params[:id])
    end

    def update
      @true_self = TrueSelf.find(params[:id])
      if @true_self.update_attributes!(true_self_params)
        flash[:success] = "Your true self was saved."
        redirect_to data_entry_true_selves_path
      else
        flash[:error] = "There was an error saving your true self."
        redirect_to edit_data_entry_true_self_path(@true_self)
      end
    end

    def destroy
      @true_self = TrueSelf.find(params[:id])
      @true_self.delete
      redirec_to data_entry_true_selves_path
    end

    protected

    def true_self_params
      params.require(:true_self).permit(:id, :name)
    end
  end
end
