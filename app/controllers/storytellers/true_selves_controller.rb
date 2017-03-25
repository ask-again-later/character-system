module Storytellers
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
        redirect_to storytellers_true_selves_path
      else
        flash[:error] = "There was an error creating your true self."
        redirect_to new_storytellers_true_self_path
      end
    end

    def edit
      @true_self = TrueSelf.find(params[:id])
    end

    def update
      @true_self = TrueSelf.find(params[:id])
      if @true_self.update_attributes!(true_self_params)
        flash[:success] = "Your true self was saved."
        redirect_to storytellers_true_selves_path
      else
        flash[:error] = "There was an error saving your true self."
        redirect_to edit_storytellers_true_self_path(@true_self)
      end
    end

    def show
      @true_self = TrueSelf.find(params[:id])
      renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, filter_html: true)
			@markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    end

    def destroy
      @true_self = TrueSelf.find(params[:id])
      @true_self.delete
      redirect_to storytellers_true_selves_path
    end

    protected

    def true_self_params
      params.require(:true_self).permit(:id, :name, :description)
    end
  end
end
