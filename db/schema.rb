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

ActiveRecord::Schema.define(version: 201702020635481) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advantages", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.text     "description",                            null: false
    t.string   "allowed_ratings",        default: ""
    t.boolean  "requires_specification", default: false
    t.string   "prerequisites",          default: ""
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_creature_challenge"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "is_custom"
  end

  create_table "character_has_advantages", force: :cascade do |t|
    t.integer  "character_id",  null: false
    t.integer  "advantage_id",  null: false
    t.integer  "rating",        null: false
    t.string   "specification"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["advantage_id"], name: "index_character_has_advantages_on_advantage_id", using: :btree
    t.index ["character_id"], name: "index_character_has_advantages_on_character_id", using: :btree
  end

  create_table "character_has_challenges", force: :cascade do |t|
    t.integer  "character_id",       null: false
    t.integer  "challenge_id",       null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "custom_name"
    t.text     "custom_description"
    t.index ["challenge_id"], name: "index_character_has_challenges_on_challenge_id", using: :btree
    t.index ["character_id"], name: "index_character_has_challenges_on_character_id", using: :btree
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "pronouns",      default: ""
    t.integer  "status",        default: 0
    t.text     "public_blurb",  default: ""
    t.integer  "user_id",                       null: false
    t.integer  "true_self_id"
    t.integer  "intelligence",  default: 1
    t.integer  "wits",          default: 1
    t.integer  "resolve",       default: 1
    t.integer  "strength",      default: 1
    t.integer  "dexterity",     default: 1
    t.integer  "stamina",       default: 1
    t.integer  "presence",      default: 1
    t.integer  "manipulation",  default: 1
    t.integer  "composure",     default: 1
    t.integer  "handy",         default: 0
    t.integer  "religion",      default: 0
    t.integer  "bureaucracy",   default: 0
    t.integer  "athletics",     default: 0
    t.integer  "fight",         default: 0
    t.integer  "drive",         default: 0
    t.integer  "guns",          default: 0
    t.integer  "theft",         default: 0
    t.integer  "stealth",       default: 0
    t.integer  "outdoorsy",     default: 0
    t.integer  "empathy",       default: 0
    t.integer  "artsy",         default: 0
    t.integer  "intimidation",  default: 0
    t.integer  "persuasion",    default: 0
    t.integer  "lies",          default: 0
    t.integer  "academics",     default: 0
    t.integer  "investigation", default: 0
    t.integer  "medicine",      default: 0
    t.integer  "local_lore",    default: 0
    t.integer  "law",           default: 0
    t.integer  "science",       default: 0
    t.integer  "computers",     default: 0
    t.integer  "engineering",   default: 0
    t.integer  "health",        default: 2,     null: false
    t.integer  "willpower",     default: 6,     null: false
    t.integer  "stability",     default: 7,     null: false
    t.integer  "defense",       default: 2,     null: false
    t.integer  "speed",         default: 6,     null: false
    t.integer  "initiative",    default: 2,     null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "use_extended",  default: false
    t.index ["true_self_id"], name: "index_characters_on_true_self_id", using: :btree
    t.index ["user_id"], name: "index_characters_on_user_id", using: :btree
  end

  create_table "questionnaire_answers", force: :cascade do |t|
    t.integer  "questionnaire_item_id", null: false
    t.integer  "character_id",          null: false
    t.text     "answer",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["character_id"], name: "index_questionnaire_answers_on_character_id", using: :btree
    t.index ["questionnaire_item_id"], name: "index_questionnaire_answers_on_questionnaire_item_id", using: :btree
  end

  create_table "questionnaire_items", force: :cascade do |t|
    t.string   "question",                                 null: false
    t.integer  "order"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "questionnaire_section_id"
    t.boolean  "required",                 default: true
    t.boolean  "extended",                 default: false
  end

  create_table "questionnaire_sections", force: :cascade do |t|
    t.string   "title"
    t.text     "instructions"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "order",        default: 0
  end

  create_table "true_selves", force: :cascade do |t|
    t.string   "name",                     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "description", default: ""
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "name",                   default: "",    null: false
    t.boolean  "is_storyteller",         default: false, null: false
    t.boolean  "is_admin",               default: false, null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "xp_records", force: :cascade do |t|
    t.integer  "character_id", null: false
    t.integer  "amount",       null: false
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["character_id"], name: "index_xp_records_on_character_id", using: :btree
  end

  add_foreign_key "character_has_advantages", "advantages"
  add_foreign_key "character_has_advantages", "characters"
  add_foreign_key "character_has_challenges", "challenges"
  add_foreign_key "character_has_challenges", "characters"
  add_foreign_key "characters", "true_selves"
  add_foreign_key "characters", "users"
  add_foreign_key "questionnaire_answers", "characters"
  add_foreign_key "questionnaire_answers", "questionnaire_items"
  add_foreign_key "xp_records", "characters"
end
