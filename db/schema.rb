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

ActiveRecord::Schema.define(version: 2020_03_08_003123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buses", primary_key: ["number", "model"], force: :cascade do |t|
    t.string "number", null: false
    t.string "model", null: false
    t.index ["number", "model"], name: "index_buses_on_number_and_model", unique: true
  end

  create_table "buses_services", force: :cascade do |t|
    t.integer "bus_id"
    t.integer "service_id"
    t.string "model"
    t.string "number"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.string "start_time"
    t.integer "duration_minutes"
    t.integer "price_cents"
    t.integer "bus_id"
    t.string "model"
    t.string "number"
  end

  add_foreign_key "buses_services", "buses", column: "model", primary_key: "model", name: "buses_services_fk"
  add_foreign_key "trips", "buses", column: "model", primary_key: "model", name: "trips_fk"
end
