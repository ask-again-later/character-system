# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
advantages_list = [
  ["Area of Expertise", "Effect: Your character is uncommonly specialized in one area. Specify a word or short phrase that represents this specific knowledge and experience your character has. Whenever the Specification applies, you gain a +1 on any Skill or Special Training with at least one dot. For example, a doctor with an Area of Expertise in Anatomy may be able to use it when targeting a specific body part with Fight, but could not with a general strike.", "1", "", true],
  ["Common Sense", "Effect: Your character has an exceptionally sound and rational mind. With a moment’s thought, she can weigh potential courses of action and outcomes. Once per season as an instant action, you may ask the Storyteller one of the following questions about a task at hand or course of action.\n\n* What is the worst choice?\n* What do I stand to lose here?\n* What’s the safest choice?\n* Am I chasing a worthless lead?", "3", "", false],
  ["Danger Sense", "Effect: Your character’s reflexes are honed to the point where nothing’s shocking. You gain a +3 modifier on reflexive Wits + Composure draws for your character to detect an impending ambush.", "2", "", false],
  ["Direction Sense", "Effect: Your character has an innate sense of direction, and is always aware of her location in space. She always knows which direction she faces, and never suffers penalties to navigate or find her way.", "1", "", false],
  ["Fun Facts", "Effect: Specify a Skill. Due to an immersion in the internet, game shows, or just a run of the mill obsession, your character has collected limitless factoids about the topic, even if she has no dots in the Skill. You can make an Intelligence + Wits draw at any time your character is dealing with her area of interest. On a successful draw, the Storyteller must give a relevant fact or detail about the issue at hand. Your character knows this fact, but you must explain within the scope of your character’s background why she knows it.", "2", "", true],
  ["Eye for the Odd", "Effect: While your character does not necessarily possess a breadth of knowledge about the supernatural, she knows the unnatural when she sees it. By perusing evidence, she can determine whether something comes from natural origins. Draw Intelligence + Composure. With a success, the Storyteller must tell you if the scene has an unnatural cause, and provide one piece of found information that confirms the answer. With an exceptional success, she must give you a bit of supernatural folklore that suggests what type of creature caused the problem. If the problem was mundane, an exceptional success gives an ongoing +3 to all draws to investigate the event, due to her redoubled certainty in its natural causation.", "2", "Resolve 2, Local Lore 2", false],
  ["Fast Reflexes", "Effect: Your character’s reflexes impress and astound; she’s always fast to react. She gains +1 Initiative at two dots, and +2 at four dots.", "2,4", "Wits 3 or Dexterity 3", false],
  ["Good Time Management", "Effect: Your character has vast experience managing complex tasks, keeping schedules, and meeting deadlines. Once per season, she may take an extra between game downtime action without Burning Down Your Life.", "3", "Bureaucracy 1", false],
  ["Holistic Awareness", "Effect: Your character is skilled at non-traditional healing methods. While scientific minds might scoff, he can provide basic medical care with natural means. He knows what herbs can stem an infection, and what minerals will stave off a minor sickness. With access to woodlands, a greenhouse, or other source of diverse flora, your character can use Local Lore instead of Medicine to heal Bruising damage at 1 dot, to downgrade Lethal to Bruising at 2 dots, or to remove the Wounded or Tilted conditions at 3 dots.", "1,2,3", "Local Lore 2", false],
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
  ["Arrogant", "The Arrogant is someone who is unafraid to flaunt their own knowledge or achievements, whether by boasting, by insisting they always know best...or by putting down anyone who threatens their sense of self-importance. However, their high personal standards also mean that they value self-improvement, and know that one’s actions are worthy of recognition. Taking a stand requires confidence, and that’s one thing the Arrogant surely doesn’t lack.
"],
  ["Betrayer", "The Betrayer understands that sometimes a situation changes, and needs to be re-evaluated for a new reality. They are not always a liar; rather, they are someone who violates trust that others have placed in them. Putting yourself first is not a fast track to keeping friends, but someone has got to look out for Number One. The Betrayer is, ultimately, eminently practical: others may be too soft to acknowledge that it’s a dog-eat-dog world, but the Betrayer will do what they must to get by."],
  ["Child", "The Child has not yet taken their place in the world, relying on others for support. Whether or not they are a literal child, their innocent outlook and trusting tendency to assume the best of those around them can be a bright spot in hard times. However, this is paired with a refusal (or inability) to shoulder responsibility. Naivety often necessitates leaning on others, regardless of their ability to hold the Child up—or their interest in doing so.
"],
  ["Clown", "The Clown wants to help people see the absurdity and levity in any situation. They don’t hesitate to point out the contradictions that others might prefer to ignore. While they may view themselves as the insightful court jester, many people will just see them as rude. Jokes have their place, and making them at the wrong time can create enemies, or worse, undermine people truly in need of aid."],
  ["Coward", "The world is a dangerous and unforgiving place, and none is more acutely aware of this than the Coward. It is sometimes said that it is in times of darkness that we find the truest measure of our souls, but the Coward is the one who instead remembers exactly what’s at risk by facing down trouble. Valuing personal security above all does not necessarily make the Coward selfish, though—fear can be an equally powerful motivator when it comes to keeping those around you safe, even if that safety is stifling."],
  ["Cruel", "Where others strive for some level of gentleness and empathy for those around them, for those who are truly Cruel, these concessions are at best exactly that—concessions, if they are not entirely a façade. The Cruel sees hurting others as both a means to their ends—a way to ensure that none stand between them and their goals—and, sometimes, an end in and of itself. While Cruelty makes few friends, it is sure to cow enemies, and isn’t it better to have someone who can do the things that the Cruel does on *your* side?"],
  ["Cynic", "The Cynic questions—traditions, authority, a hand extended in aid; nothing is above their doubt and scrutiny. They consistently take the least charitable view of the world and people around them. This is not, at its core, a bad impulse: ultimately, the Cynic recognizes that things always have the potential to be better than they are, and never accepts anything \"just because.\" However, this comes with the risk of self-isolation and inaction, when no person, or no choice, seems worthy of trust."],
  ["Deceiver", "The Deceiver is a liar and a con artist. There’s nothing personal about it, really—the Deceiver isn’t out to betray any particular person, and indeed may be a truly loyal friend and ally. Rather, for the Deceiver, dishonesty is a way of life. This is because they understand, perhaps better than anyone, that truth is the most valuable currency there is, and that there is no reason to spend it freely, especially not when lies are so versatile—and let the Deceiver be so much less vulnerable. Of course, should others discover the lies, the Deceiver is likely to be cast out, regardless of whether or not they acted with malice."],
  ["Dreamer", "The Dreamer is an optimist, willing and able to imagine a better, kinder world. And, regardless of the doubts and slights of others, the Dreamer welcomes the changes it will take to make their vision a reality. Unfortunately, big ideas and a gentle soul do not necessarily translate to the practical know-how to actually improve the lives of those around them, and others may find the Dreamer to be woefully out of touch with reality."],
  ["Drifter", ""],
  ["Easy", ""],
  ["Fussy", ""],
  ["Gossip", ""],
  ["Hedonist", ""],
  ["Hoodlum", ""],
  ["Layabout", ""],
  ["Martyr", ""],
  ["Misanthrope", ""],
  ["Monster", ""],
  ["Narcissist", ""],
  ["Obsessed", ""],
  ["Scrooge", ""],
  ["Tyrant", ""],
  ["Upstart", ""],
  ["Violent", ""],
  ["Weirdo", ""]
]

users_list = [
  ["test_user@test.test", "welcome", "test user please ignore", false, false],
  ["clarkkent@superman.super", "welcome", "Clark Kent", false, false],
  ["athena@greekgods.god", "welcome", "Athena Goddess of Wisdom", false, false],
  ["st1@askagainlater.com", "welcome", "Storyteller 1", true, false],
  ["st2@askagainlater.com", "welcome", "Storyteller 2", true, false],
  ["st3@askagainlater.com", "welcome", "Storyteller 3", true, false],
  ["admin1@askagainlater.com", "welcome", "Admin", true, true],
  ["admin2@askagainlater.com", "welcome", "Admin", true, true],
  ["player1@askagainlater.com", "welcome", "Player 1", false, false],
  ["player2@askagainlater.com", "welcome", "Player 2", false, false],
  ["player3@askagainlater.com", "welcome", "Player 3", false, false],
  ["player4@askagainlater.com", "welcome", "Player 4", false, false],
  ["player5@askagainlater.com", "welcome", "Player 5", false, false],
  ["player6@askagainlater.com", "welcome", "Player 6", false, false],
  ["player7@askagainlater.com", "welcome", "Player 7", false, false],
  ["player8@askagainlater.com", "welcome", "Player 8", false, false]
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

true_selves_list.each do |name, description|
  puts "Creating seed True Selves"
  TrueSelf.create(name: name, description: description)
end

users_list.each do |email, password, name, is_storyteller, is_admin|
  puts "Creating seed Users"
  User.create(email: email, password: password, password_confirmation: password, name: name, is_storyteller: is_storyteller, is_admin: is_admin)
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
