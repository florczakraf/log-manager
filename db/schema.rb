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

ActiveRecord::Schema.define(version: 20141110224521) do

  create_table "players", force: true do |t|
    t.string   "guid"
    t.boolean  "banned"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", force: true do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "port"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "ip"
    t.string   "port"
    t.string   "user"
    t.string   "pass"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_update"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activated"
    t.boolean  "admin"
  end

  create_table "violations", force: true do |t|
    t.string   "date"
    t.string   "type_name"
    t.integer  "player_id"
    t.string   "details"
    t.string   "ip"
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "violations", ["date", "type_name", "player_id", "details", "ip", "server_id"], name: "my_index", unique: true

end
