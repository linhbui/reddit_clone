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

ActiveRecord::Schema.define(version: 20141110052354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.string   "content",           null: false
    t.integer  "author_id",         null: false
    t.integer  "post_id",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_comment_id"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["parent_comment_id"], name: "index_comments_on_parent_comment_id", using: :btree
  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content"
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["title"], name: "index_posts_on_title", using: :btree

  create_table "sub_posts", force: true do |t|
    t.integer  "sub_id",     null: false
    t.integer  "post_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_posts", ["sub_id", "post_id"], name: "index_sub_posts_on_sub_id_and_post_id", unique: true, using: :btree

  create_table "subs", force: true do |t|
    t.string   "title",        null: false
    t.string   "description",  null: false
    t.integer  "moderator_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subs", ["moderator_id"], name: "index_subs_on_moderator_id", using: :btree
  add_index "subs", ["title"], name: "index_subs_on_title", unique: true, using: :btree

  create_table "user_votes", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "value",        null: false
    t.integer  "votable_id",   null: false
    t.string   "votable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_votes", ["user_id", "votable_id", "votable_type"], name: "index_user_votes_on_user_id_and_votable_id_and_votable_type", unique: true, using: :btree
  add_index "user_votes", ["votable_id", "votable_type"], name: "index_user_votes_on_votable_id_and_votable_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
