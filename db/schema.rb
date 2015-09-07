# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150907201532) do

  create_table "banishments", force: :cascade do |t|
    t.integer  "character_id", null: false
    t.integer  "fraction_id",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "banishments", ["character_id", "fraction_id"], name: "index_banishments_on_character_id_and_fraction_id", unique: true
  add_index "banishments", ["fraction_id"], name: "index_banishments_on_fraction_id"

  create_table "characters", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.string   "gender",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "characters", ["name"], name: "index_characters_on_name", unique: true
  add_index "characters", ["user_id"], name: "index_characters_on_user_id"

  create_table "electorates", force: :cascade do |t|
    t.integer  "fraction_id", null: false
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "electorates", ["fraction_id"], name: "index_electorates_on_fraction_id"
  add_index "electorates", ["name", "fraction_id"], name: "index_electorates_on_name_and_fraction_id", unique: true

  create_table "fractions", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "ancestry"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "founder_id",                 null: false
    t.string   "founder_type",               null: false
    t.integer  "ancestry_depth", default: 0
  end

  add_index "fractions", ["ancestry"], name: "index_fractions_on_ancestry"
  add_index "fractions", ["founder_type", "founder_id"], name: "index_fractions_on_founder_type_and_founder_id"
  add_index "fractions", ["name"], name: "index_fractions_on_name", unique: true

  create_table "government_authorizations", force: :cascade do |t|
    t.integer  "authorizer_id",      null: false
    t.string   "authorizer_type",    null: false
    t.integer  "authorizee_id",      null: false
    t.string   "authorizee_type",    null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "authorization_type", null: false
  end

  add_index "government_authorizations", ["authorizer_type", "authorizer_id", "authorizee_type", "authorizee_id", "authorization_type"], name: "index_government_authorizations_uniquely", unique: true

  create_table "land_authorizations", force: :cascade do |t|
    t.integer  "authorizer_id",      null: false
    t.integer  "authorizee_id",      null: false
    t.string   "authorizee_type",    null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "authorization_type", null: false
  end

  add_index "land_authorizations", ["authorizee_type", "authorizee_id"], name: "index_land_authorizations_on_authorizee_type_and_authorizee_id"
  add_index "land_authorizations", ["authorizer_id"], name: "index_land_authorizations_on_authorizer_id"

  create_table "plots", force: :cascade do |t|
    t.integer  "region_id"
    t.integer  "world_id",   null: false
    t.integer  "x",          null: false
    t.integer  "z",          null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "plots", ["region_id"], name: "index_plots_on_region_id"
  add_index "plots", ["world_id", "x", "z"], name: "index_plots_on_world_id_and_x_and_z", unique: true
  add_index "plots", ["x"], name: "index_plots_on_x"
  add_index "plots", ["z"], name: "index_plots_on_z"

  create_table "position_memberships", force: :cascade do |t|
    t.integer  "character_id", null: false
    t.integer  "position_id",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "position_memberships", ["character_id", "position_id"], name: "index_position_memberships_on_character_id_and_position_id", unique: true
  add_index "position_memberships", ["position_id"], name: "index_position_memberships_on_position_id"

  create_table "positions", force: :cascade do |t|
    t.integer  "fraction_id", null: false
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "positions", ["fraction_id"], name: "index_positions_on_fraction_id"
  add_index "positions", ["name", "fraction_id"], name: "index_positions_on_name_and_fraction_id", unique: true

  create_table "regions", force: :cascade do |t|
    t.integer  "fraction_id", null: false
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "regions", ["fraction_id"], name: "index_regions_on_fraction_id"
  add_index "regions", ["name", "fraction_id"], name: "index_regions_on_name_and_fraction_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "uuid",                 null: false
    t.string   "password_digest",      null: false
    t.string   "session_token",        null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "current_character_id"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username"
  add_index "users", ["uuid"], name: "index_users_on_uuid", unique: true

  create_table "worlds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
