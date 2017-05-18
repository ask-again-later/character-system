module Storytellers
  class StatisticsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Statistics", :storytellers_true_selves_path

    def index
      if params[:status].present?
        status = params[:status]
      else
        status = 1
      end
      @total = get_characters_total(status)
      @creatures = get_creatures(status)
      @unnatural = get_unnatural(status)
    end

    private

    def get_characters_total(status)
      Character.where(status: status).length
    end

    def get_creatures(status)
      characters = Character.where(status: status).joins(:challenges)
      data = {
        "Witch": characters.where("challenges.id = :cid", cid: Challenge.where(name: "Witch").first.id).length,
        "Werewolf": characters.where("challenges.id = :cid", cid: Challenge.where(name: "Werewolf").first.id).length,
        "Vampire": characters.where("challenges.id = :cid", cid: Challenge.where(name: "Vampire").first.id).length,
        "Demonblooded": characters.where("challenges.id = :cid", cid: Challenge.where(name: "Demonblooded").first.id).length,
        "Other": Character.where(status: status).joins(:character_has_challenges).where("character_has_challenges.challenge_id = :cid and character_has_challenges.is_creature_challenge = true", cid: Challenge.where(name: "New Challenge").first.id).length
      }
      data
    end

    def get_unnatural_count(status)
      Character.where(status: status).joins(:advantages).where("advantages.is_unnatural = true").uniq.length
    end

    def true_self_counts(status)
      Character.where(status: status).group_by {|c| c.true_self}.map{|ts, cs| [ts.name, cs.length]}
    end

    def get_stat_spread(status, stat)
      characters = Character.where(status: status)
      characters.group_by{|c| c.send(stat) }.map{|x, y| [x, y.length]}.sort{|a,b| b[0] <=> a[0]}
    end
  end
end
