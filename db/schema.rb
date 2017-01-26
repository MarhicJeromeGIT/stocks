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

ActiveRecord::Schema.define(version: 20170126212254) do

  create_table "alerts", force: :cascade do |t|
    t.string   "alert_type"
    t.integer  "stock_id"
    t.decimal  "target_value", precision: 8, scale: 3
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "contact"
    t.string   "status"
    t.integer  "user_id"
    t.index ["stock_id"], name: "index_alerts_on_stock_id"
    t.index ["user_id"], name: "index_alerts_on_user_id"
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

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",      null: false
    t.string   "encrypted_password",                default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "authentication_token",   limit: 30
    t.string   "provider",                          default: "email", null: false
    t.string   "uid",                               default: "",      null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.text     "tokens"
    t.integer  "role",                              default: 0
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
