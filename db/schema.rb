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

ActiveRecord::Schema.define(version: 2019_04_02_120803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charges", force: :cascade do |t|
    t.string "status"
    t.string "code"
    t.string "description"
    t.integer "quantity"
    t.string "unit"
    t.decimal "rate"
    t.decimal "profit"
    t.string "bill_to_name"
    t.decimal "quantity_expense"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commodities", force: :cascade do |t|
    t.string "status"
    t.integer "reference"
    t.integer "pieaces"
    t.string "package"
    t.string "description"
    t.string "dimension"
    t.decimal "weight"
    t.decimal "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commodity_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consignees", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "containers", force: :cascade do |t|
    t.decimal "length"
    t.decimal "width"
    t.decimal "height"
    t.decimal "tare_weight"
    t.decimal "next_weight"
    t.decimal "total_weight"
    t.decimal "volume"
    t.decimal "vol_weight"
    t.decimal "square_pt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "quantity"
    t.string "units"
    t.string "rates"
    t.decimal "amount"
    t.string "currency"
    t.string "payment"
    t.date "date"
    t.string "vendor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incomes", force: :cascade do |t|
    t.integer "quantity"
    t.string "units"
    t.string "rates"
    t.decimal "amount"
    t.string "currency"
    t.string "payment"
    t.date "date"
    t.string "bill_to_address"
    t.string "bill_to_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issuing_companies", force: :cascade do |t|
    t.string "company_name"
    t.string "company_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_blacklist", id: :serial, force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "mode_of_transportations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "order_number"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "shippment_id"
    t.index ["shippment_id"], name: "index_orders_on_shippment_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shippers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "custom_name"
    t.string "website"
    t.string "place_id"
    t.string "city"
    t.string "vicinity"
  end

  create_table "shippments", force: :cascade do |t|
    t.integer "order_number"
    t.string "origin_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "service_type"
    t.string "destination_name"
    t.bigint "issuing_company_id"
    t.bigint "consignee_id"
    t.bigint "shipper_id"
    t.bigint "agent_id"
    t.bigint "mode_of_transportation_id"
    t.index ["agent_id"], name: "index_shippments_on_agent_id"
    t.index ["consignee_id"], name: "index_shippments_on_consignee_id"
    t.index ["issuing_company_id"], name: "index_shippments_on_issuing_company_id"
    t.index ["mode_of_transportation_id"], name: "index_shippments_on_mode_of_transportation_id"
    t.index ["shipper_id"], name: "index_shippments_on_shipper_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.string "provider"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "orders", "shippments"
  add_foreign_key "orders", "users"
  add_foreign_key "shippments", "agents"
  add_foreign_key "shippments", "consignees"
  add_foreign_key "shippments", "issuing_companies"
  add_foreign_key "shippments", "mode_of_transportations"
  add_foreign_key "shippments", "shippers"
end
