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

ActiveRecord::Schema.define(version: 2020_02_16_212210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buses", force: :cascade do |t|
    t.string "number"
    t.string "model"
  end

  create_table "buses_services", force: :cascade do |t|
    t.bigint "bus_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_id", "service_id"], name: "index_buses_services_on_bus_id_and_service_id"
    t.index ["bus_id"], name: "index_buses_services_on_bus_id"
    t.index ["service_id", "bus_id"], name: "index_buses_services_on_service_id_and_bus_id"
    t.index ["service_id"], name: "index_buses_services_on_service_id"
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
    t.integer "bus_id"
  end

  add_foreign_key "buses_services", "buses"
  add_foreign_key "buses_services", "services"
end
