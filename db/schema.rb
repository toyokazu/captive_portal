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

ActiveRecord::Schema.define(version: 20171022124856) do

  create_table "access_logs", force: :cascade do |t|
    t.string "ap_type"
    t.string "ap_mac"
    t.string "essid"
    t.string "mac"
    t.string "ip"
    t.string "uid"
    t.string "provider"
    t.boolean "agreement"
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.datetime "updated_at", null: false
  end

  create_table "attribute_logs", force: :cascade do |t|
    t.string "amac"
    t.string "portal_locale"
    t.string "locale"
    t.string "location"
    t.string "gender"
    t.string "email"
    t.string "age_range"
    t.string "timezone"
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.datetime "updated_at", null: false
  end

  create_table "hash_salts", force: :cascade do |t|
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
