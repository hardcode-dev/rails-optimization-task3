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

ActiveRecord::Schema.define(version: 2023_10_30_150533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buses", force: :cascade do |t|
    t.string "number"
    t.string "model"
  end

  create_table "buses_services", force: :cascade do |t|
    t.integer "bus_id"
    t.integer "service_id"
    t.index ["bus_id"], name: "index_buses_services_on_bus_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "pghero_query_stats", force: :cascade do |t|
    t.text "database"
    t.text "user"
    t.text "query"
    t.bigint "query_hash"
    t.float "total_time"
    t.bigint "calls"
    t.datetime "captured_at"
    t.index ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "duration_minutes"
    t.integer "price_cents"
    t.integer "bus_id"
    t.time "start_time"
    t.index ["from_id", "to_id"], name: "index_trips_on_from_id_and_to_id"
  end

end
