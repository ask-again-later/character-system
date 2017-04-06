class CharacterMailerPreview < ActionMailer::Preview
  def character_submission
    CharacterMailer.character_submission(Character.first, User.where({is_storyteller: true}).first)
  end

  def character_approval
    CharacterMailer.character_approval(Character.first)
  end
end
