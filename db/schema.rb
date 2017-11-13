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

ActiveRecord::Schema.define(version: 20171113072939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chowdowns", force: :cascade do |t|
    t.integer "food_id", null: false
    t.datetime "chow_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_chowdowns_on_food_id"
  end

  create_table "eatings", force: :cascade do |t|
    t.integer "food_id", null: false
    t.integer "meal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_eatings_on_food_id"
    t.index ["meal_id"], name: "index_eatings_on_meal_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name", null: false
    t.integer "amount_g", default: 1, null: false
    t.integer "calories", default: 0
    t.integer "protein", default: 0
    t.integer "carbs", default: 0
    t.integer "fat", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "meal_foods", force: :cascade do |t|
    t.bigint "food_id"
    t.bigint "meal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "num_servings"
    t.index ["food_id"], name: "index_meal_foods_on_food_id"
    t.index ["meal_id"], name: "index_meal_foods_on_meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.datetime "meal_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "meal_foods", "foods"
  add_foreign_key "meal_foods", "meals"
end
