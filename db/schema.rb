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

ActiveRecord::Schema.define(version: 20180526040651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "deadline"
    t.bigint "project_id", null: false
    t.bigint "column_id", null: false
    t.integer "assignee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_cards_on_column_id"
    t.index ["name", "project_id"], name: "index_cards_on_name_and_project_id", unique: true
    t.index ["project_id"], name: "index_cards_on_project_id"
  end

  create_table "columns", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 0, null: false
    t.index ["name", "project_id"], name: "index_columns_on_name_and_project_id", unique: true
    t.index ["order", "project_id"], name: "index_columns_on_order_and_project_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accept", default: false
    t.index ["project_id"], name: "index_invitations_on_project_id"
    t.index ["user_id", "project_id"], name: "index_invitations_on_user_id_and_project_id", unique: true
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "logs", force: :cascade do |t|
    t.string "content", default: "", null: false
    t.string "image", default: "", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_logs_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider", default: "", null: false
    t.string "uid", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.string "image"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "cards", "columns"
  add_foreign_key "cards", "projects"
  add_foreign_key "logs", "projects"
end
