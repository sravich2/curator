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

ActiveRecord::Schema.define(version: 20150717061925) do

  create_table "articles", force: :cascade do |t|
    t.string   "feedly_id"
    t.string   "title"
    t.string   "author"
    t.text     "content"
    t.string   "url"
    t.text     "topics"
    t.text     "tags"
    t.text     "entities"
    t.text     "locations"
    t.datetime "published"
    t.integer  "feed_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "readability_url"
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "website"
    t.integer  "subscribers"
    t.string   "feedly_id"
    t.string   "topics"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "favicon_url"
    t.string   "logo_url"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["article_id"], name: "index_likes_on_article_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "feed_id"
    t.string   "feed_feedly_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "subscriptions", ["feed_id"], name: "index_subscriptions_on_feed_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.text     "oauth_token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
