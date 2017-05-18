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

ActiveRecord::Schema.define(version: 201712020230224) do

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
    t.boolean  "is_unnatural",           default: false
  end

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_creature_challenge", default: false
    t.boolean  "is_custom",             default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
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
    t.integer  "character_id",                          null: false
    t.integer  "challenge_id",                          null: false
    t.string   "custom_name"
    t.text     "custom_description"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "is_creature_challenge", default: false
    t.index ["challenge_id"], name: "index_character_has_challenges_on_challenge_id", using: :btree
    t.index ["character_id"], name: "index_character_has_challenges_on_character_id", using: :btree
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name",            default: ""
    t.string   "pronouns",        default: ""
    t.integer  "status",          default: 0
    t.text     "public_blurb",    default: ""
    t.integer  "user_id",                         null: false
    t.integer  "true_self_id"
    t.integer  "intelligence",    default: 1
    t.integer  "wits",            default: 1
    t.integer  "resolve",         default: 1
    t.integer  "strength",        default: 1
    t.integer  "dexterity",       default: 1
    t.integer  "stamina",         default: 1
    t.integer  "presence",        default: 1
    t.integer  "manipulation",    default: 1
    t.integer  "composure",       default: 1
    t.integer  "handy",           default: 0
    t.integer  "religion",        default: 0
    t.integer  "bureaucracy",     default: 0
    t.integer  "athletics",       default: 0
    t.integer  "fight",           default: 0
    t.integer  "drive",           default: 0
    t.integer  "guns",            default: 0
    t.integer  "theft",           default: 0
    t.integer  "stealth",         default: 0
    t.integer  "outdoorsy",       default: 0
    t.integer  "empathy",         default: 0
    t.integer  "artsy",           default: 0
    t.integer  "intimidation",    default: 0
    t.integer  "persuasion",      default: 0
    t.integer  "lies",            default: 0
    t.integer  "academics",       default: 0
    t.integer  "investigation",   default: 0
    t.integer  "medicine",        default: 0
    t.integer  "local_lore",      default: 0
    t.integer  "law",             default: 0
    t.integer  "science",         default: 0
    t.integer  "computers",       default: 0
    t.integer  "engineering",     default: 0
    t.integer  "health",          default: 2
    t.integer  "willpower",       default: 6
    t.integer  "stability",       default: 7
    t.integer  "defense",         default: 2
    t.integer  "speed",           default: 6
    t.integer  "initiative",      default: 2
    t.boolean  "use_extended",    default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "approval_sent",   default: false
    t.boolean  "is_npc",          default: false
    t.text     "additional_info", default: ""
    t.index ["true_self_id"], name: "index_characters_on_true_self_id", using: :btree
    t.index ["user_id"], name: "index_characters_on_user_id", using: :btree
  end

  create_table "characters_equipment", force: :cascade do |t|
    t.integer "character_id"
    t.integer "equipment_id"
  end

  create_table "characters_rituals", force: :cascade do |t|
    t.integer "character_id"
    t.integer "ritual_id"
  end

  create_table "downtime_actions", force: :cascade do |t|
    t.string   "title",                              null: false
    t.string   "assets"
    t.boolean  "burn",               default: false
    t.text     "description",                        null: false
    t.boolean  "is_submitted",       default: false
    t.text     "response"
    t.integer  "downtime_period_id",                 null: false
    t.integer  "character_id",                       null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "size",               default: 0
    t.integer  "status",             default: 0
    t.integer  "action_type",        default: 0,     null: false
  end

  create_table "downtime_periods", force: :cascade do |t|
    t.string   "title"
    t.boolean  "downtimes_visible"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "downtimes_open",    default: false
    t.boolean  "is_active",         default: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string  "name",                           null: false
    t.integer "size"
    t.integer "durability"
    t.integer "equipment_type_id",              null: false
    t.text    "description",       default: ""
  end

  create_table "equipment_equipment_qualities", force: :cascade do |t|
    t.integer "equipment_id"
    t.integer "equipment_quality_id"
  end

  create_table "equipment_qualities", force: :cascade do |t|
    t.string  "name",              null: false
    t.integer "equipment_type_id", null: false
    t.string  "description"
  end

  create_table "equipment_qualities_equipment_types", force: :cascade do |t|
  end

  create_table "equipment_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "questionnaire_answers", force: :cascade do |t|
    t.integer  "questionnaire_item_id",              null: false
    t.integer  "character_id",                       null: false
    t.text     "answer",                default: ""
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["character_id"], name: "index_questionnaire_answers_on_character_id", using: :btree
    t.index ["questionnaire_item_id"], name: "index_questionnaire_answers_on_questionnaire_item_id", using: :btree
  end

  create_table "questionnaire_items", force: :cascade do |t|
    t.string   "question",                                 null: false
    t.integer  "order"
    t.integer  "questionnaire_section_id", default: 1
    t.boolean  "required",                 default: true
    t.boolean  "extended",                 default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "questionnaire_sections", force: :cascade do |t|
    t.string   "title"
    t.text     "instructions"
    t.integer  "order",        default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "rituals", force: :cascade do |t|
    t.string "principle"
    t.string "trappings"
    t.string "focus"
    t.text   "effect"
    t.string "duration"
    t.string "name"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "xp_expenditures", force: :cascade do |t|
    t.integer  "character_id",                 null: false
    t.string   "diff"
    t.integer  "amount",       default: 0
    t.boolean  "is_approved",  default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
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
