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

ActiveRecord::Schema.define(version: 20140213022921) do

  create_table "admin_panels", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datapoints", force: true do |t|
    t.integer  "experiment_id"
    t.integer  "user_id"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "compliance"
    t.decimal  "iv_value"
    t.string   "comment"
    t.decimal  "init_value"
  end

  create_table "enrolls", force: true do |t|
    t.integer  "user_id"
    t.integer  "experiment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.datetime "recording_time"
    t.boolean  "is_active"
    t.datetime "end_time"
    t.datetime "next_time"
  end

  create_table "experiments", force: true do |t|
    t.string   "action"
    t.string   "control"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author"
    t.string   "prereqs"
    t.boolean  "is_public"
    t.string   "timeinterval"
    t.string   "timeframe_units"
    t.integer  "timeframe"
    t.string   "category"
    t.boolean  "must_email"
    t.integer  "pend_status",     default: 0
    t.boolean  "spanning_action", default: true
  end

  create_table "pending_experiments", force: true do |t|
    t.string   "action"
    t.string   "control"
    t.integer  "author"
    t.string   "prereqs"
    t.boolean  "is_public"
    t.string   "timeinterval"
    t.string   "timeframe_units"
    t.integer  "timeframe"
    t.string   "category"
    t.boolean  "must_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experiment_id"
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

  create_table "variables", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unit"
    t.integer  "experiment_id"
    t.boolean  "has_init_value"
  end

end
