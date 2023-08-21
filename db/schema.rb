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

ActiveRecord::Schema[7.0].define(version: 2023_08_21_082034) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_ins", force: :cascade do |t|
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.bigint "ski_resorts_id"
    t.index ["ski_resorts_id"], name: "index_check_ins_on_ski_resorts_id"
    t.index ["users_id"], name: "index_check_ins_on_users_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "comment"
    t.integer "waiting_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "check_ins_id"
    t.index ["check_ins_id"], name: "index_reviews_on_check_ins_id"
  end

  create_table "ski_resorts", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "description"
    t.integer "average_rating"
    t.string "url"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "snow_reports", force: :cascade do |t|
    t.datetime "checked_out_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "check_ins_id"
    t.index ["check_ins_id"], name: "index_snow_reports_on_check_ins_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.integer "age"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "check_ins", "ski_resorts", column: "ski_resorts_id"
  add_foreign_key "check_ins", "users", column: "users_id"
  add_foreign_key "reviews", "check_ins", column: "check_ins_id"
  add_foreign_key "snow_reports", "check_ins", column: "check_ins_id"
end
