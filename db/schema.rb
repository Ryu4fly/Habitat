# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_01_104948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer "amount"
    t.bigint "user_id", null: false
    t.bigint "lane_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "gambler_id"
    t.index ["gambler_id"], name: "index_bets_on_gambler_id"
    t.index ["lane_id"], name: "index_bets_on_lane_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.date "date"
    t.integer "craving"
    t.string "feeling"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cig_smoked"
    t.string "context"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "habits", force: :cascade do |t|
    t.float "cost_a_pack"
    t.integer "avg_cig"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "lanes", force: :cascade do |t|
    t.bigint "race_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_lanes_on_race_id"
    t.index ["user_id"], name: "index_lanes_on_user_id"
  end

  create_table "losses", force: :cascade do |t|
    t.integer "placing"
    t.bigint "user_id", null: false
    t.bigint "race_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_losses_on_race_id"
    t.index ["user_id"], name: "index_losses_on_user_id"
  end

  create_table "races", force: :cascade do |t|
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "public"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.integer "days_smoke_free"
    t.string "preferred_currency"
    t.integer "balance"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "race_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_wins_on_race_id"
    t.index ["user_id"], name: "index_wins_on_user_id"
  end

  add_foreign_key "bets", "lanes"
  add_foreign_key "bets", "users"
  add_foreign_key "bets", "users", column: "gambler_id"
  add_foreign_key "entries", "users"
  add_foreign_key "habits", "users"
  add_foreign_key "lanes", "races"
  add_foreign_key "lanes", "users"
  add_foreign_key "losses", "races"
  add_foreign_key "losses", "users"
  add_foreign_key "wins", "races"
  add_foreign_key "wins", "users"
end
