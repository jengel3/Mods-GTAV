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

ActiveRecord::Schema.define(version: 20150406222535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "key"
    t.string "version"
    t.string "user_id"
  end

  create_table "blog_posts", force: :cascade do |t|
    t.integer  "author_id"
    t.text     "body"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "like_count",    default: 0
    t.integer  "user_id"
    t.integer  "submission_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
  end

  add_index "comments", ["deleted_at"], name: "index_comments_on_deleted_at", using: :btree
  add_index "comments", ["submission_id"], name: "index_comments_on_submission_id", using: :btree

  create_table "dislikes", force: :cascade do |t|
    t.string   "dislikable_type"
    t.integer  "dislikable_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
  end

  create_table "downloads", force: :cascade do |t|
    t.inet     "ip_address"
    t.integer  "submission_id"
    t.datetime "created_at",    null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "location"
    t.integer  "submission_id"
    t.string   "image"
    t.datetime "created_at",    null: false
  end

  add_index "images", ["submission_id"], name: "index_images_on_submission_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.string   "likable_type"
    t.string   "user_id"
    t.integer  "likable_id"
    t.datetime "created_at"
  end

  create_table "submissions", force: :cascade do |t|
    t.string   "name"
    t.text     "body"
    t.text     "baked_body"
    t.time     "approved_at"
    t.string   "category"
    t.string   "sub_category"
    t.integer  "like_count",     default: 0
    t.integer  "dislike_count",  default: 0
    t.integer  "download_count", default: 0
    t.integer  "avg_rating",     default: 0
    t.time     "last_favorited"
    t.integer  "creator_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
  end

  add_index "submissions", ["slug"], name: "index_submissions_on_slug", unique: true, using: :btree

  create_table "uploads", force: :cascade do |t|
    t.text     "changelog"
    t.time     "approved_at"
    t.string   "size"
    t.integer  "submission_id"
    t.string   "upload"
    t.datetime "created_at",    null: false
    t.string   "version"
  end

  add_index "uploads", ["submission_id"], name: "index_uploads_on_submission_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.string   "username"
    t.boolean  "admin"
    t.text     "biography"
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.string   "steam_id"
    t.boolean  "email_approval",         default: true
    t.boolean  "email_reports",          default: true
    t.boolean  "email_comments",         default: true
    t.boolean  "email_news",             default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
