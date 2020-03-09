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

ActiveRecord::Schema.define(version: 2020_03_09_155753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "buses", primary_key: ["number", "model"], force: :cascade do |t|
    t.string "number", null: false
    t.string "model", null: false
    t.index ["number", "model"], name: "index_buses_on_number_and_model", unique: true
  end

  create_table "buses_services", force: :cascade do |t|
    t.integer "service_id"
    t.string "model"
    t.string "number"
    t.index ["model", "number", "service_id"], name: "index_buses_services_on_model_and_number_and_service_id"
    t.index ["service_id", "model", "number"], name: "index_buses_services_on_service_id_and_model_and_number"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_cities_on_name"
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
    t.string "model"
    t.string "number"
    t.index ["from_id", "to_id"], name: "index_trips_on_from_id_and_to_id"
  end

  add_foreign_key "buses_services", "buses", column: "model", primary_key: "model", name: "buses_services_fk"
  add_foreign_key "trips", "buses", column: "model", primary_key: "model", name: "trips_fk"
end
