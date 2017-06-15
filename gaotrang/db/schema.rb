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

ActiveRecord::Schema.define(version: 20170614133316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_lines", force: :cascade do |t|
    t.integer  "quantity"
    t.float    "price"
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_lines_on_cart_id", using: :btree
    t.index ["product_id"], name: "index_cart_lines_on_product_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.float    "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "available_on"
    t.string   "slug"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.json     "payload"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "categories"
    t.float    "price"
    t.index ["slug"], name: "index_products_on_slug", using: :btree
  end

end
