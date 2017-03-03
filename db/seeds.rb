# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
advantages_list = [
  ["Dread Attack", "This is a description of Dread Attacks", "1,2,3", "Strength 3", false],
  ["Drain", "This is a description of Drain", "3", "", true],
  ["Resources", "How much money, yo", "1,2,3,4,5", "", false],
  ["Allies", "Your friends yo", "1,2,3,4,5", "", true]
]

challenges_list = [
  ["Alcoholic", "You have a problem :(", false],
  ["Vampire", "I vant to suck your blud", true],
  ["Witch", "Spells and stuff", true],
  ["Single Parent", "You are a single parent", false]
]

questionnaire_items_list = [
  ["Are you a player?", 1],
  ["Do you enjoy cheese?", 2],
  ["What about cows?", 3]
]

true_selves_list = [
  "Arrogant",
  "Child",
  "Drifter",
  "Coward",
  "Tyrant"
]

users_list = [
  ["test_user@test.test", "welcome", "test user please ignore"],
  ["clarkkent@superman.super", "welcome", "Clark Kent"],
  ["athena@greekgods.god", "welcome", "Athena Goddess of Wisdom"],
]

characters_list =  [
  ["Shaggy", 1, 4, 3, 0, 0, 3, 0, 2, 0, 0, 3, 3, 2, 3, 0, 2, 0, 0, 4, 0, 0, 0,
   0, 0, 0, "Scooby's BFF, pothead", 6, 2, 6, 4, 2, 2, 3, 2, 3, 4, 3, 2, 2, 2,
   6, "he/him", 1],
  ["Yog-Sothoth", 3, 1, 0, 5, 5, 5, 5, 0, 0, 5, 5, 5, 0, 5, 5, 5, 5, 5, 0, 0, 5,
   5, 5, 5, 5, "Sadistic Outer God from beyond the stars.", 15, 20, 25, 1, 5, 5, 5,
   5, 5, 5, 5, 5, 5, 15, 20, "Lurker at the Threshold/Opener of the Way", 1]
]

character_advantages_list = [
  [1, 3, 1],
  [1, 4, 5, "The Mystery Gang"],
  [2, 1, 3],
  [2, 2, 3, "Willpower"],
  [2, 3, 5],
  [2, 4, 5, "Cultists"],
  [2, 4, 5, "Other Outer Gods"]
]

character_challenges_list = [
  [1, 1],
  [2, 3]
]

questionnaire_answers_list = [
  [1, 1, "Yep!"],
  [2, 1, "Cheese is delicious, duh"],
  [3, 1, "Cows are pretty cool, I guess"],
  [1, 2, "There will be no more play once the Way is Opened"],
  [2, 2, "Cheese is insignificant, but delcious, I suppose"],
  [3, 2, "Cows are also ok. The Lurker at the Threshold has no issue with them."]
]

xp_records_list = [
  [1, 5, "For coming to game"],
  [2, 999, "No number can truly capture the experience of the Opener of the Way"]
]

advantages_list.each do |name, description, allowed_ratings, prerequisites, requires_specification|
  puts "Creating Advangtages"
  Advantage.create(name: name, description: description,
                   allowed_ratings: allowed_ratings, prerequisites: prerequisites,
                   requires_specification: requires_specification)
end

challenges_list.each do |name, description, is_creature_challenge|
  puts "Creating seed challenges"
  Challenge.create(name: name, description: description,
                   is_creature_challenge: is_creature_challenge)
end

questionnaire_items_list.each do |question, order|
  puts "Creating seed Questions"
  QuestionnaireItem.create(question: question, order: order)
end

true_selves_list.each do |name|
  puts "Creating seed True Selves"
  TrueSelf.create(name: name)
end

users_list.each do |email, password, name|
  puts "Creating seed Users"
  User.create(email: email, password: password, password_confirmation: password, name: name)
end

characters_list.each do |name, user_id, stability, handy, religion, bureaucracy,
                         athletics, fight, drive, guns, theft, stealth, outdoorsy,
                         empathy, artsy, intimidation, persuasion, lies, academics,
                         investigation, medicine, local_lore, law, science, computers,
                         engineering, public_blurb, willpower, defense, speed,
                         true_self_id, intelligence, wits, resolve, strength, dexterity,
                         stamina, presence, manipulation, composure, initiative, health,
                         pronouns, status|
  puts "Creating seed Characters"
  Character.create(name: name, user_id: user_id, stability: stability, handy: handy,
                   religion: religion, bureaucracy: bureaucracy, athletics: athletics, fight: fight,
                   drive: drive, guns: guns, theft: theft, stealth: stealth, outdoorsy: outdoorsy,
                   empathy: empathy, artsy: artsy, intimidation: intimidation, persuasion: persuasion,
                   lies: lies, academics: academics, investigation: investigation, medicine: medicine,
                   local_lore: local_lore, law: law, science: science, computers: computers,
                   engineering: engineering, public_blurb: public_blurb, willpower: willpower,
                   defense: defense, speed: speed, true_self_id: true_self_id, intelligence: intelligence,
                   wits: wits, resolve: resolve, strength: strength, dexterity: dexterity, stamina: stamina,
                   presence: presence, manipulation: manipulation, composure: composure, initiative: initiative,
                   health: health, pronouns: pronouns, status: status)
end

character_advantages_list.each do |character_id, advantage_id, rating, specification|
  puts "Tying seed Characters to seed Advantages"
  CharacterHasAdvantage.create(character_id: character_id, advantage_id: advantage_id,
                               rating: rating, specification: specification)
end

character_challenges_list.each do |character_id, challenge_id|
  puts "Tying seed Characters to seed Challenges"
  CharacterHasChallenge.create(character_id: character_id, challenge_id: challenge_id)
end

questionnaire_answers_list.each do |questionnaire_item_id, character_id, answer|
  puts "Answering seed Questions for seed Characters"
  QuestionnaireAnswer.create(questionnaire_item_id: questionnaire_item_id, character_id: character_id, answer: answer)
end

xp_records_list.each do |character_id, amount, description|
  puts "Giving seed XP to seed Characters"
  XpRecord.create(character_id: character_id, amount: amount, description: description)
end
