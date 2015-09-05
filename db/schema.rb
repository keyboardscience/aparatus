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

ActiveRecord::Schema.define(version: 20150831043758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts_teams", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "team_id",    null: false
  end

  add_index "accounts_teams", ["account_id", "team_id"], name: "index_accounts_teams_on_account_id_and_team_id", using: :btree
  add_index "accounts_teams", ["team_id", "account_id"], name: "index_accounts_teams_on_team_id_and_account_id", using: :btree

  create_table "clusters", force: :cascade do |t|
    t.string   "name"
    t.integer  "type_id"
    t.integer  "team_id"
    t.datetime "lease"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "available"
  end

  create_table "databases", force: :cascade do |t|
    t.string   "name"
    t.integer  "cluster_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.integer  "cluster_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "available"
  end

end