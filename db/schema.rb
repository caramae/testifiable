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

ActiveRecord::Schema.define(version: 20131225232626) do

  create_table "datapoints", force: true do |t|
    t.integer  "experiment_id"
    t.integer  "user_id"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "compliance"
    t.decimal  "value2"
    t.string   "comment"
  end

  create_table "enrolls", force: true do |t|
    t.integer  "user_id"
    t.integer  "experiment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "randomize"
    t.datetime "recording_time"
    t.boolean  "is_active"
    t.datetime "end_time"
  end

  create_table "experiments", force: true do |t|
    t.string   "action"
    t.string   "control"
    t.string   "outcome"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author"
    t.string   "prereqs"
    t.boolean  "is_public"
    t.integer  "timeframe",       limit: 255
    t.string   "timeinterval"
    t.string   "timeframe_units"
  end

  create_table "outcomes", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.boolean  "is_admin",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
