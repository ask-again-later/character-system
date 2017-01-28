# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170128210601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advantages", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "rating"
    t.string   "specification"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "challenges", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_creature_challenge"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "character_has_advantages", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "advantage_id"
    t.integer  "rating"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "character_has_challenges", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "challenge_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "true_self_id"
    t.integer  "stability"
    t.integer  "handy"
    t.integer  "religion"
    t.integer  "bureaucracy"
    t.integer  "athletics"
    t.integer  "fight"
    t.integer  "drive"
    t.integer  "guns"
    t.integer  "theft"
    t.integer  "stealth"
    t.integer  "outdoorsy"
    t.integer  "empathy"
    t.integer  "artsy"
    t.integer  "intimidation"
    t.integer  "persuasion"
    t.integer  "lies"
    t.integer  "academics"
    t.integer  "investigation"
    t.integer  "medicine"
    t.integer  "local_lore"
    t.integer  "law"
    t.integer  "science"
    t.integer  "computers"
    t.integer  "engineering"
    t.text     "public_blurb"
    t.integer  "willpower"
    t.integer  "defense"
    t.integer  "speed"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "questionnaire_answers", force: :cascade do |t|
    t.integer  "questionnaire_item_id"
    t.integer  "character_id"
    t.text     "answer"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "questionnaire_items", force: :cascade do |t|
    t.string   "question"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "true_selves", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "name",                   default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "pronouns"
    t.boolean  "is_storyteller",         default: false
    t.boolean  "is_admin",               default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "xp_records", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "amount"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
