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

ActiveRecord::Schema[8.0].define(version: 2025_02_14_164236) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "buses", force: :cascade do |t|
    t.string "number"
    t.string "model"
    t.index ["number"], name: "index_buses_on_number", unique: true
  end

  create_table "buses_services", force: :cascade do |t|
    t.integer "bus_id"
    t.integer "service_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_services_on_name", unique: true
  end

  create_table "trips", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.string "start_time"
    t.integer "duration_minutes"
    t.integer "price_cents"
    t.integer "bus_id"
  end
end
