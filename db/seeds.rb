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

questionnaire_sections_list = [
  ["About Your Character", 1],
  ["Your Character's Struggles", 2],
  ["Optional Questions", 3],
  ["Additional Information", 4],
  ["Extended Written Proposal", 5]
]

questionnaire_items_list = [
  ["What are your character’s most valued Norms? What shocks or offends your character?", 1, 1, true, false],
  ["What is your character's goal in life?", 2, 1, true, false],
  ["What is your character’s day-to-day life like? Do they have any hobbies? What do they do to make money? How do they have fun?", 3, 1, true, false],
  ["Describe your character's personal life. What's their relationship like with their parents? Do they have any close friends? Romantic relationships? Children or siblings?", 4, 1, true, false],
  ["What are your character's religious/spiritual views?", 5, 1, true, false],
  ["How does your character deal with hardship and stress?", 6, 2, true, false],
  ["What is one memory your character has of the unexplainable? Why has it stuck with them?", 7, 2],
  ["What is your character most afraid of?", 8, 2, true, false],
  ["What does your character consider to be the worst thing they have ever done?", 9, 2, true, false],
  ["Has your character had any traumatic experiences? Describe the one that affected them the most.", 10, 2, true, false],
  ["What does your character think makes someone or something a monster?", 11, 2, true, false],
  ["If you are a supernatural creature, how did you become one? Was it your choice? How has it changed your life? How do you hide your unnatural state?", 12, 2, true, false],
  ["Has your character ever left Nulpert County, or Winnemac? If so why? Why did they return to Osthigwanegon?", 13, 3, false, false],
  ["How has life been unfair to your character? Why does your character believe they haven’t gotten further in life?", 14, 3, false, false],
  ["What is your character hiding from the people around them? What is their most closely kept secret?", 15, 3, false, false],
  ["What does loss mean to your character? What is a noteworthy loss they have experienced?", 16, 3, false, false],
  ["What is one thing your character believes about themselves, that isn't actually true?", 17, 3, false, false],
  ["What does your character believe makes for a successful life?", 18, 3, false, false],
  ["Under what circumstances would your character kill another human being?", 19, 3, false, false],
  ["What does your character like about their life?", 20, 3, false, false],
  ["What is your character’s proudest achievement?", 21, 3, false, false],
  ["Is there anything else we need to know about your character or their history?", 22, 4, false, false],
  ["What are your goals for your character, OOC, if any?", 23, 4, false, false],
  ["Describe your character’s profession, career, level of education, or majority of their daily life in detail. What are they good at? What are they bad at? Mention specific Skills or Special Trainings if possible.", 24, 5, true, true],
  ["What Norms does your character struggle with? What makes them an outsider? Mention specific True Selves and Challenges if possible.", 25, 5, true, true],
  ["Is your character able to do things that others cannot? Are they supernatural in any way? Weirdly good at that one thing? Mention specific Advantages if possible.", 26, 5, true, true],
  ["What are your character’s hobbies? Does your character have any specific membership within or to connections to a group, whether public or private?", 27, 5, true, true],
  ["Is there anything else you have seen in the specific mechanics you would like your character to be able to do? Anything you want to avoid, whether for complexity reasons or otherwise?", 28, 5, true, true],
  ["Is there any particular part of the setting not yet mentioned you want to engage with? Anything you want to avoid?", 29, 5, true, true]
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

questionnaire_sections_list.each do |section, order|
  puts "Creating seed Questionnaire Sections"
  QuestionnaireSection.create(title: section, order: order)
end

questionnaire_items_list.each do |question, order, section, required, extended|
  puts "Creating seed Questions"
  QuestionnaireItem.create(question: question, order: order, questionnaire_section_id: section, required: required, extended: extended)
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
