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
