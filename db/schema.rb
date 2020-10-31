# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_201_031_201_153) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pg_stat_statements'
  enable_extension 'plpgsql'

  create_table 'bus_services', force: :cascade do |t|
    t.bigint 'service_id'
    t.bigint 'bus_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['bus_id'], name: 'index_bus_services_on_bus_id'
    t.index ['service_id'], name: 'index_bus_services_on_service_id'
  end

  create_table 'buses', force: :cascade do |t|
    t.string 'number'
    t.string 'model'
    t.index %w[model number], name: 'index_buses_on_model_and_number'
  end

  create_table 'buses_services', force: :cascade do |t|
    t.integer 'bus_id'
    t.integer 'service_id'
  end

  create_table 'cities', force: :cascade do |t|
    t.string 'name'
    t.index ['name'], name: 'index_cities_on_name'
  end

  create_table 'pghero_query_stats', force: :cascade do |t|
    t.text 'database'
    t.text 'user'
    t.text 'query'
    t.bigint 'query_hash'
    t.float 'total_time'
    t.bigint 'calls'
    t.datetime 'captured_at'
    t.index %w[database captured_at], name: 'index_pghero_query_stats_on_database_and_captured_at'
  end

  create_table 'services', force: :cascade do |t|
    t.string 'name'
    t.index ['name'], name: 'index_services_on_name'
  end

  create_table 'trips', force: :cascade do |t|
    t.integer 'from_id'
    t.integer 'to_id'
    t.string 'start_time'
    t.integer 'duration_minutes'
    t.integer 'price_cents'
    t.integer 'bus_id'
    t.index %w[to_id from_id], name: 'index_trips_on_to_id_and_from_id'
  end
end
