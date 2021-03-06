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

ActiveRecord::Schema.define(version: 20161126023042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.boolean  "disabled",   default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "responses", force: :cascade do |t|
    t.text     "body",                       null: false
    t.boolean  "handled",    default: false, null: false
    t.integer  "seat_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["handled"], name: "index_responses_on_handled", using: :btree
    t.index ["seat_id"], name: "index_responses_on_seat_id", using: :btree
  end

  create_table "seats", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "email",      limit: 255, null: false
    t.integer  "team_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["team_id", "email"], name: "index_seats_on_team_id_and_email", unique: true, using: :btree
    t.index ["team_id"], name: "index_seats_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "account_id",             null: false
    t.string   "time_zone",              null: false
    t.index ["account_id", "name"], name: "index_teams_on_account_id_and_name", unique: true, using: :btree
    t.index ["account_id"], name: "index_teams_on_account_id", using: :btree
    t.index ["time_zone"], name: "index_teams_on_time_zone", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "account_id",                          null: false
    t.index ["account_id"], name: "index_users_on_account_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "responses", "seats"
  add_foreign_key "seats", "teams"
  add_foreign_key "teams", "accounts"
  add_foreign_key "users", "accounts"
end
