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

ActiveRecord::Schema.define(version: 20150419023318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "confession_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "comments", ["confession_id"], name: "index_comments_on_confession_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "confessions", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "school_id"
  end

  create_table "hashtags", force: :cascade do |t|
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "school_id"
  end

  add_index "school_users", ["school_id"], name: "index_school_users_on_school_id", using: :btree
  add_index "school_users", ["user_id"], name: "index_school_users_on_user_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "hashtag_id"
    t.integer  "confession_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["confession_id"], name: "index_taggings_on_confession_id", using: :btree
  add_index "taggings", ["hashtag_id"], name: "index_taggings_on_hashtag_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.string   "oauth_token"
    t.string   "birthday"
    t.string   "location"
    t.string   "education_history"
    t.datetime "oauth_expiry_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "timezone"
  end

  add_foreign_key "school_users", "schools"
  add_foreign_key "school_users", "users"
  add_foreign_key "taggings", "confessions"
  add_foreign_key "taggings", "hashtags"
end
