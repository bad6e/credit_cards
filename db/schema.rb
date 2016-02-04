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

ActiveRecord::Schema.define(version: 20160204003017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "bonus", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "spending_amount"
    t.date     "record_date"
    t.integer  "card_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "bonus", ["card_id"], name: "index_bonus_on_card_id", using: :btree

  create_table "cards", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "annual_fee"
    t.text     "information", default: [],              array: true
    t.string   "apr"
    t.string   "intro_rate"
    t.string   "image_link"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
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

  add_foreign_key "bonus", "cards"
  add_foreign_key "categorizings", "cards"
  add_foreign_key "categorizings", "categories"
end
