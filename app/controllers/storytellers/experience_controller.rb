module Storytellers
  class ExperienceController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path

    def index
      @expenditures = XpExpenditure.where(is_approved: false)
      @records = XpRecord.all.order(created_at: :desc)

      add_breadcrumb "Experience", storytellers_experience_path
    end

    def new
      @xpr = XpRecord.new
      add_breadcrumb "Experience", storytellers_experience_path
      add_breadcrumb "Add Experience to Character", storytellers_new_experience_record_path
    end

    def create
      @character = Character.find(params[:xp_record][:character_id])
      @xpr = XpRecord.new(xp_record_params)
      @xpr.save
      redirect_to storytellers_experience_path and return
    end

    def show
      @xpe = XpExpenditure.find(params[:id])

      add_breadcrumb "Experience", storytellers_experience_path
      add_breadcrumb "Experience Expenditure for #{@xpe.character.name}", storytellers_show_experience_expenditure_path
    end

    def mass_assign
      @characters = Character.where(status: 2, is_npc: false)
      @characters.each do |char|
        @xpr = XpRecord.new(character_id: char.id, amount: params[:amount], description: params[:description])
        @xpr.save
      end
      redirect_to storytellers_experience_path and return
    end

    def approve_expenditure
      @xpe = XpExpenditure.find(params[:id])
      @character = @xpe.character
      diff = @xpe.diff
      log = []
      JSON.parse(@xpe.diff).each do |item, val|
        if item != "character_has_advantages" and item != "character_has_challenges"
          @character.send("#{item}=", val[1])
          log.push("#{item.titleize} #{val[1]}")
        elsif item == "character_has_advantages"
          advantages_old = val[0]
          advantages_new = val[1]
          advantages_removed = advantages_old.select{|ao| advantages_new.index{|an| an['id'] == ao['id']}.nil?}
          advantages_updated = advantages_new.select{|an| ab = advantages_old.bsearch{|ao| an['id'] == ao['id']}; ab.present? ? ab['rating'] != an['rating'] : false}
          advantages_added = advantages_new.select{|an| an['id'].nil?}
          advantages_removed.each{|ar| CharacterHasAdvantage.destroy(ar['id'])}
          advantages_updated.each{|au| @character.character_has_advantages.where(id: au['id']).first.rating = au['rating']}
          advantages_added.each{|aa| @character.character_has_advantages.push(CharacterHasAdvantage.new(advantage_id: aa['advantage_id'], rating: aa['rating'], specification: aa['specification']))}
        elsif item == "character_has_challenges"
          challenges_old = val[0]
          challenges_new = val[1]
          challenges_added = challenges_new.select{|cn| cn['id'].nil?}
          challenges_removed = challenges_old.select{|co| challenges_new.index{|cn| cn['id'] == co['id']}.nil?}
          challenges_removed.each{|cr| CharacterHasChallenge.destroy(cr['id'])}
          challenges_added.each{|ca| @character.character_has_challenges.push(CharacterHasChallenge.new(challenge_id: ca['challenge_id'], custom_name: ca['custom_name'], custom_description: ca['custom_description']))}
        end
      end
      @character.save
      @xpe.update_attributes(is_approved: true)
      @xpr = XpRecord.new(character_id: @character.id, amount: @xpe.amount*-1, description: log.join(", "))
      @xpr.save
      redirect_to storytellers_experience_path and return
    end

    def destroy
      XpRecord.destroy(params[:id])
      redirect_to storytellers_experience_path and return
    end

    def destroy_expenditure
      XpExpenditure.destroy(params[:id])
      redirect_to storytellers_experience_path and return
    end

    private

    def xp_record_params
      params.require(:xp_record).permit(:id, :character_id, :amount, :description)
    end
  end
end
