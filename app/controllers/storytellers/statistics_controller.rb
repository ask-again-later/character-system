module Storytellers
  class StatisticsController < ApplicationController
    before_action :authenticate_user!, :requires_storyteller

    add_breadcrumb "Storytellers", :storytellers_path
    add_breadcrumb "Statistics", :storytellers_statistics_path

    ATTRIBUTES = {"Mental": ["Intelligence", "Wits", "Resolve"], "Physical": ["Strength", "Dexterity", "Stamina"], "Social": ["Presence", "Manipulation", "Composure"]}
    SKILLS_TRAINING = {"Skills": ["Artsy", "Athletics", "Bureaucracy", "Drive", "Empathy", "Fight", "Guns", "Handy", "Intimidation", "Lies", "Outdoorsy", "Persuasion", "Religion", "Stealth", "Theft"], "Special Training": ["Academics", "Computers", "Engineering", "Investigation", "Law", "Local Lore", "Medicine", "Science"]}
    STATUS_ENUM = [["In Progress", 0], ["Submitted", 1], ["Active", 2], ["Inactive", 3]]

    def index
      if params[:status].present?
        status = params[:status].to_i
      else
        status = 2
      end
      @status_name = STATUS_ENUM[status][0]
      @statuses = STATUS_ENUM
      @total = get_characters_total(status)
      @creatures = get_creatures(status)
      @unnatural = get_unnatural_count(status)
      @true_selves = true_self_counts(status)
      @skills_training = {}
      SKILLS_TRAINING.each do |grname, stats|
        @skills_training[grname] = {}
        stats.each do |stat|
          @skills_training[grname][stat.parameterize('_').to_sym] = get_stat_spread(status, stat.parameterize('_').to_sym)
        end
      end
    end

    private

    def get_characters_total(status)
      Character.where({status: status, is_npc: false}).length
    end

    def get_creatures(status)
      characters = Character.where({status: status, is_npc: false}).joins(:challenges)
      creature_challenges = Challenge.where(is_custom: false)
      data = {}
      creature_challenges.each do |cc|
        data[cc.name.downcase.parameterize.to_sym] = characters.where("challenges.id = :cid", cid: cc.id).length
      end
      data[:other] = Character.where(status: status).joins(:character_has_challenges).where("character_has_challenges.challenge_id = :cid and character_has_challenges.is_creature_challenge = true", cid: Challenge.where(is_custom: true).first.id).length
      data
    end

    def get_unnatural_count(status)
      Character.where({status: status, is_npc: false}).joins(:advantages).where("advantages.is_unnatural = true").uniq.length
    end

    def true_self_counts(status)
      Character.where({status: status, is_npc: false}).group_by {|c| c.true_self}.map{|ts, cs| [ts.name, cs.length]}
    end

    def get_stat_spread(status, stat)
      characters = Character.where({status: status, is_npc: false})
      characters.group_by{|c| c.send(stat) }.map{|x, y| [x, y.length]}.sort{|a,b| a[0] <=> b[0]}
    end
  end
end
