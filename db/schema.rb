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

ActiveRecord::Schema[7.0].define(version: 2023_08_16_081758) do
  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "service_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_appointments_on_customer_id"
    t.index ["service_id"], name: "index_appointments_on_service_id"
  end

  create_table "calendar_events", force: :cascade do |t|
    t.integer "appointment_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_calendar_events_on_appointment_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.string "email"
    t.string "phone_number"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "services"
  add_foreign_key "calendar_events", "appointments"
end
