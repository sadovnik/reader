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

ActiveRecord::Schema.define(version: 20170329150028) do

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.string   "key"
    t.integer  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_entries", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "status",     default: 0
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["post_id"], name: "index_post_entries_on_post_id"
    t.index ["user_id"], name: "index_post_entries_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "internal_id"
    t.string   "title"
    t.string   "summary"
    t.string   "url"
    t.integer  "source_id"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["source_id"], name: "index_posts_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "type"
    t.string   "url"
    t.string   "site_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_subscriptions_on_source_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
