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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120813060405) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "venue_id"
    t.string   "chaos"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "url"
    t.string   "day"
  end

  create_table "events_panelists", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "panelist_id"
  end

  add_index "events_panelists", ["event_id", "panelist_id"], :name => "index_events_panelists_on_event_id_and_panelist_id"
  add_index "events_panelists", ["panelist_id", "event_id"], :name => "index_events_panelists_on_panelist_id_and_event_id"

  create_table "panelists", :force => true do |t|
    t.string   "name"
    t.text     "title"
    t.string   "affiliation"
    t.string   "twitter"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "schedule_entries", :force => true do |t|
    t.integer "schedule_id"
    t.integer "event_id"
    t.string  "notes"
  end

  create_table "schedules", :force => true do |t|
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string "identifier"
    t.string "email"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "chaos"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "code"
  end

end
