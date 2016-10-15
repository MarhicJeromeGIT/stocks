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

ActiveRecord::Schema.define(version: 20161014081006) do

  create_table "alerts", force: :cascade do |t|
    t.string   "alert_type"
    t.integer  "stock_id"
    t.decimal  "target_value", precision: 8, scale: 3
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "contact"
    t.index ["stock_id"], name: "index_alerts_on_stock_id"
  end

  create_table "stock_live_infos", force: :cascade do |t|
    t.decimal  "value_now",      precision: 8, scale: 3
    t.decimal  "value_open",     precision: 8, scale: 3
    t.decimal  "value_high",     precision: 8, scale: 3
    t.decimal  "value_low",      precision: 8, scale: 3
    t.decimal  "variation_now",  precision: 8, scale: 3
    t.decimal  "variation_year", precision: 8, scale: 3
    t.integer  "volume"
    t.integer  "traded_amount"
    t.decimal  "exchanged_capi", precision: 8, scale: 2
    t.datetime "date"
    t.integer  "stock_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["stock_id"], name: "index_stock_live_infos_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "code"
    t.string   "codif"
    t.string   "name"
    t.string   "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end