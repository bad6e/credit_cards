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

ActiveRecord::Schema.define(version: 20160510190543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "blogs", force: :cascade do |t|
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "slug"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "image_url"
    t.boolean  "published",         default: false
    t.string   "related_image_url"
  end

  create_table "card_blogs", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "card_blogs", ["blog_id"], name: "index_card_blogs_on_blog_id", using: :btree
  add_index "card_blogs", ["card_id"], name: "index_card_blogs_on_card_id", using: :btree

  create_table "cards", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "annual_fee"
    t.text     "information",     default: [],              array: true
    t.string   "apr"
    t.string   "intro_rate"
    t.string   "image_link"
    t.string   "best_offer"
    t.string   "flyer_talk_link"
    t.string   "point_type"
    t.string   "image_url"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.string   "description"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "categorizings", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "card_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categorizings", ["card_id"], name: "index_categorizings_on_card_id", using: :btree
  add_index "categorizings", ["category_id"], name: "index_categorizings_on_category_id", using: :btree

  create_table "favorite_cards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorite_cards", ["card_id"], name: "index_favorite_cards_on_card_id", using: :btree
  add_index "favorite_cards", ["user_id"], name: "index_favorite_cards_on_user_id", using: :btree

  create_table "rewards", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "spending_amount"
    t.date     "record_date"
    t.integer  "card_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "length_of_time"
    t.string   "apply_link",      default: "N/A"
    t.integer  "dollar_amount"
    t.float    "cent_value"
    t.string   "reward_type"
  end

  add_index "rewards", ["card_id"], name: "index_rewards_on_card_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "location"
    t.string   "image_url"
    t.string   "url"
    t.boolean  "updated_email"
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "card_blogs", "blogs"
  add_foreign_key "card_blogs", "cards"
  add_foreign_key "categorizings", "cards"
  add_foreign_key "categorizings", "categories"
  add_foreign_key "favorite_cards", "cards"
  add_foreign_key "favorite_cards", "users"
  add_foreign_key "rewards", "cards"
end
